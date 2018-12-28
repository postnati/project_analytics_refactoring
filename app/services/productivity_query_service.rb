# frozen_string_literal: true

# Queries productivity data and aggegates the data into time groupings
class ProductivityQueryService
  class << self
    def query_productivity(time_grouping, resource_group, locale)
      productivity_data = ProductivityDataService.new(time_grouping)
      current_group_ended_at = productivity_data.oldest_group_ended_at

      EffortWeek.all.order(ended_at: :asc).each do |week|
        current_group_ended_at = add_week_project_effort(week, resource_group, locale, productivity_data, current_group_ended_at)
      end

      productivity_data
    end

    def add_week_project_effort(week, resource_group, locale, productivity_data, current_group_ended_at)
      most_recent_time_group_ended_at = productivity_data.most_recent_time_group_ended_at
      if most_recent_time_group_ended_at.blank? || (week.ended_at > most_recent_time_group_ended_at)
        current_group_ended_at += productivity_data.time_group_ended_at_offset
        productivity_data.add_effort_for_time_group(current_group_ended_at, 0.0, 0.0)
      end

      productivity_data.add_effort_for_time_group(
        current_group_ended_at,
        query_project_effort(week, resource_group, locale),
        query_total_effort(week, resource_group, locale)
      )
    end

    def query_project_effort(week, resource_group, locale)
      EffortEntry.select(:effort).joins(:effort_week, effort_bucket: :project, team_member: %i[resource_groups locale])
                 .where(effort_weeks: { ended_at: week.ended_at },
                        resource_groups: { id: resource_group.id },
                        locales: { id: locale.id })
                 .where.not(effort_buckets: { project_id: nil }).sum(:effort)
    end

    def query_total_effort(week, resource_group, locale)
      EffortEntry.select(:effort).joins(:effort_week, effort_bucket: :effort_bucket_group, team_member: %i[resource_groups locale])
                 .where(effort_weeks: { ended_at: week.ended_at },
                        resource_groups: { id: resource_group.id },
                        locales: { id: locale.id })
                 .where.not(effort_bucket_groups: { name: ['Time Off'] }).sum(:effort)
    end
  end
end
