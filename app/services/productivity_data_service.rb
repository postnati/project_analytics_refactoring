# frozen_string_literal: true

# Stores all the aggregated time groupings and returns the data in multiple formats
class ProductivityDataService
  attr_reader :time_group_ended_at_offset
  attr_reader :time_grouping

  def initialize(time_grouping)
    @groupings = {}
    @time_grouping = time_grouping
    @time_group_ended_at_offset = determine_time_group_offset
  end

  def add_effort_for_time_group(ended_at, project_effort, total_effort)
    if !@groupings.include?(ended_at)
      @groupings[ended_at] = ProductivityGroupDataService.new(ended_at, project_effort, total_effort)
    else
      @groupings[ended_at].project_effort += project_effort
      @groupings[ended_at].total_effort += total_effort
    end

    ended_at
  end

  def most_recent_time_group_ended_at
    return nil if @groupings.empty?

    @groupings.keys.max
  end

  def rows
    @groupings.values.map do |grouping|
      [grouping.time_group_ended_at, grouping.project_effort, grouping.total_effort, grouping.utilization]
    end
  end

  def csv
    headers = ['Week End Date', 'Project Effort', 'Total Effort', 'Utilization']

    CSV.generate(col_sep: "\t") do |csv|
      csv << headers
      rows.each do |row|
        csv << row
      end
    end
  end

  def chart_data
    @groupings.values.map do |grouping|
      [grouping.time_group_ended_at.to_i * 1000, grouping.utilization.to_i]
    end
  end

  def oldest_group_ended_at
    oldest_week_ended_at = EffortWeek.order(ended_at: :asc).first.ended_at - 1.week
    oldest_week_ended_at + time_group_ended_at_offset
  end

  def determine_time_group_offset
    if @time_grouping == 'monthly'
      1.month
    elsif @time_grouping == 'quarterly'
      3.months
    else
      1.week
    end
  end
end
