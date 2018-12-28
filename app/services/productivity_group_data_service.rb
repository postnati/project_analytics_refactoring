# frozen_string_literal: true

# Services one time grouping of aggregated productivity data
class ProductivityGroupDataService
  attr_accessor :time_group_ended_at, :project_effort, :total_effort

  def initialize(time_group_ended_at, project_effort, total_effort)
    @time_group_ended_at = time_group_ended_at
    @project_effort = project_effort
    @total_effort = total_effort
  end

  def utilization
    ((@project_effort / @total_effort).round(3) * 100).to_s + '%'
  end
end
