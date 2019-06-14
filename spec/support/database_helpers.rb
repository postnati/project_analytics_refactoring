# frozen_string_literal: true

module DatabaseHelpers
  def seed_database
    echecks_bucket_group = create(:effort_bucket_group, name: 'eChecks')
    other_bucket_group = create(:effort_bucket_group, name: 'Other')

    new_dev_category = create(:dev_category, name: 'New')
    update_dev_category = create(:dev_category, name: 'Update')

    other_bucket = create(
      :effort_bucket,
      name: 'Other', effort_bucket_group: other_bucket_group
    )
    physical_checks_bucket = create(
      :effort_bucket,
      name: 'Physical Checks',
      project: create(:project, name: 'Physical Checks', dev_category: new_dev_category),
      effort_bucket_group: echecks_bucket_group
    )
    electronic_checks_bucket = create(
      :effort_bucket,
      name: 'Electronic Checks',
      project: create(:project, name: 'Electronic Checks', dev_category: update_dev_category),
      effort_bucket_group: echecks_bucket_group
    )

    effort_buckets = [physical_checks_bucket, electronic_checks_bucket, other_bucket]

    dev_resource_group = create(:resource_group, name: 'dev')
    qa_resource_group = create(:resource_group, name: 'qa')
    grand_rapids_locale = create(:locale, name: 'Grand Rapids')
    minneapolis_locale = create(:locale, name: 'Minneapolis')

    generate_team_member_effort(dev_resource_group, grand_rapids_locale, effort_buckets, 52)
    generate_team_member_effort(dev_resource_group, minneapolis_locale, effort_buckets, 52)
    generate_team_member_effort(qa_resource_group, grand_rapids_locale, effort_buckets, 52)
    generate_team_member_effort(qa_resource_group, minneapolis_locale, effort_buckets, 52)
  end

  def generate_team_member_effort(resource_group, locale, buckets, number_of_weeks)
    team_member = create(:team_member, locale: locale)
    create(:resource_assignment, team_member: team_member, resource_group: resource_group)

    week_ending_at = DateTime.now.at_beginning_of_week - ((number_of_weeks * 7) + 1).days

    while week_ending_at <= DateTime.now
      effort_week = create(:effort_week, ended_at: week_ending_at)
      add_random_effort(team_member, effort_week, buckets)
      week_ending_at += 7.days
    end
  end

  def add_random_effort(team_member, effort_week, buckets)
    remaining_effort = 5.0

    # Add Effort in Days
    buckets.each_with_index do |bucket, index|
      next unless remaining_effort.positive?

      effort = index == (buckets.size - 1) ? remaining_effort : Random.rand(0.1..remaining_effort).round(1)
      create(
        :effort_entry,
        team_member: team_member, effort_week: effort_week, effort_bucket: bucket, effort: effort
      )
      remaining_effort = (remaining_effort - effort).round(1)
    end
  end
end

RSpec.configuration.include DatabaseHelpers, type: :feature
