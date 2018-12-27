class ProductivityController < ApplicationController
  def index
    @resource_groups = ResourceGroups.all
    @locale = Locales.all
  end

  def show
    @time_groupings = ["weekly", "monthly", "quarterly"]

    @time_grouping = params[:time_grouping] || "weekly"
    @resource_group = ResourceGroup.find_by_name(params[:resource_group_name] || "l3")
    @locale = Locale.find_by_name(params[:locale_name] || "Raleigh")

    @headers = ["Week End Date","Project Effort","Total Effort","Utilization"]
    @data_rows = []

    group_ended_at_offset = 1.week

    if(@time_grouping == "monthly")
      group_ended_at_offset = 1.month
    elsif(@time_grouping == "quarterly")
      group_ended_at_offset = 3.months
    end

    oldest_week_ended_at = EffortWeek.order(:ended_at => :asc).first.ended_at-1.week
    current_group_ended_at = oldest_week_ended_at + group_ended_at_offset
    groupings = {}
    groupings[current_group_ended_at]  = {project_effort: 0.0, total_effort: 0.0}

    EffortWeek.all.order(:ended_at => :asc).each do |week|
      if(week.ended_at > current_group_ended_at)
        current_group_ended_at += group_ended_at_offset
        groupings[current_group_ended_at]  = {project_effort: 0.0, total_effort: 0.0}
      end

      groupings[current_group_ended_at][:project_effort] += EffortEntry.select(:effort).joins(:effort_week, :effort_bucket => :project, :team_member => [:resource_groups, :locale]).where(:effort_weeks => {ended_at: week.ended_at}, :resource_groups => {:id => @resource_group.id}, :locales => {:id => @locale.id}).where.not(:effort_buckets => {project: nil}).sum(:effort)
      groupings[current_group_ended_at][:total_effort] += EffortEntry.select(:effort).joins(:effort_week, :effort_bucket => :effort_bucket_group, :team_member => [:resource_groups, :locale]).where(:effort_weeks => {ended_at: week.ended_at}, :resource_groups => {:id => @resource_group.id}, :locales => {:id => @locale.id}).where.not(:effort_bucket_groups => {name: ["Time Off"]}).sum(:effort)
    end

    groupings.sort.each do |group_ended_at, values|
      project_effort = values[:project_effort]
      total_effort = values[:total_effort]
      @data_rows << [group_ended_at, project_effort, total_effort, (((project_effort/total_effort).round(3))*100).to_s + "%"]
    end

    respond_to do |format|
      format.html do
        @chart_title = "#{@time_grouping.camelcase} Productivity for [#{@resource_group.name}] in [#{@locale.name}]"
        @chart_data = @data_rows.map do |row|
          [row[0].to_i*1000,row[3].to_i]
        end.to_json
      end

      format.json do
        @data_rows = @data_rows.map do |row|
          [row[0].to_i*1000,row[3]]
        end

        render :json => {
          caption: "#{@time_grouping.camelcase} Productivity for [#{@resource_group.name}] in [#{@locale.name}]",
          series: [
            {
              label: "Productivity",
              data: @data_rows,
              minValue: 0,
              maxValue: 100
            }
          ]
        }
      end

      format.csv do
        csv_output = CSV.generate({:col_sep => "\t"}) do |csv|
          csv << @headers
          @data_rows.each do |row|
            csv << row
          end
        end

        render plain: csv_output
      end
    end
  end

  def filter
    logger.info(filter_params)

    redirect_to({
      controller: 'productivity',
      action: 'show',
      locale_name: Locale.find(filter_params[:locale_id]).name,
      resource_group_name: ResourceGroup.find(filter_params[:resource_group_id]).name,
      time_grouping: filter_params[:time_grouping]
    })
  end

  private
    def filter_params
      params.require(:data_filter).permit(:locale_id, :resource_group_id, :time_grouping)
    end
end
