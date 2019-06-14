# frozen_string_literal: true

# Reports on Productivity for team members
class ProductivityController < ApplicationController
  def index
    @resource_groups = ResourceGroups.all
    @locale = Locales.all
  end

  def show
    @time_groupings = %w[weekly monthly quarterly]

    @time_grouping = params[:time_grouping] || 'weekly'
    @resource_group = ResourceGroup.find_by_name(params[:resource_group_name] || 'dev')
    @locale = Locale.find_by_name(params[:locale_name] || 'Minneapolis')

    productivity_data = ProductivityQueryService.query_productivity(@time_grouping, @resource_group, @locale)

    generate_show_response(productivity_data)
  end

  def generate_show_response(productivity_data)
    respond_to do |format|
      format.html do
        @chart_title = "#{@time_grouping.camelcase} Productivity for [#{@resource_group.name}] in [#{@locale.name}]"
        @chart_data = productivity_data.chart_data
      end

      format.csv do
        render plain: productivity_data.csv
      end
    end
  end

  def filter
    logger.info(filter_params)

    redirect_to(
      controller: 'productivity',
      action: 'show',
      locale_name: Locale.find(filter_params[:locale_id]).name,
      resource_group_name: ResourceGroup.find(filter_params[:resource_group_id]).name,
      time_grouping: filter_params[:time_grouping]
    )
  end

  private

  def filter_params
    params.require(:data_filter).permit(:locale_id, :resource_group_id, :time_grouping)
  end
end
