# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database
# with its default values. The data can then be loaded with the rake db:seed
# (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# ---------------------------------------
# Project Check In Bucket Groups
# ---------------------------------------
echecks_bucket_group = EffortBucketGroup.find_or_initialize_by(name: 'eChecks')
echecks_bucket_group.save!
other_bucket_group = EffortBucketGroup.find_or_initialize_by(name: 'Other')
other_bucket_group.save!

# ---------------------------------------
# Dev Categories
# ---------------------------------------
new_dev_category = DevCategory.find_or_initialize_by(name: 'New')
new_dev_category.save!
update_dev_category = DevCategory.find_or_initialize_by(name: 'Update')
update_dev_category.save!

# ---------------------------------------
# Projects and Project Check In Buckets
# ---------------------------------------
other_bucket = EffortBucket.find_or_initialize_by(name: 'Other')
other_bucket.effort_bucket_group = other_bucket_group
other_bucket.save!

project = Project.find_or_initialize_by(name: 'Physical Checks')
project.dev_category = new_dev_category
project.save!
physical_checks_bucket = EffortBucket.find_or_initialize_by(name: 'Physical Checks')
physical_checks_bucket.project = project
physical_checks_bucket.effort_bucket_group = echecks_bucket_group
physical_checks_bucket.save!

project = Project.find_or_initialize_by(name: 'Electronic Checks')
project.dev_category = update_dev_category
project.save!
electronic_checks_bucket = EffortBucket.find_or_initialize_by(name: 'Electronic Checks')
electronic_checks_bucket.project = project
electronic_checks_bucket.effort_bucket_group = echecks_bucket_group
electronic_checks_bucket.save!

# ---------------------------------------
# Resource Groups
# ---------------------------------------
dev_resource_group = ResourceGroup.find_or_initialize_by(name: 'dev')
dev_resource_group.save!
qa_resource_group = ResourceGroup.find_or_initialize_by(name: 'qa')
qa_resource_group.save!

# ---------------------------------------
# Locale
# ---------------------------------------
grand_rapids_locale = Locale.find_or_initialize_by(name: 'Grand Rapids')
grand_rapids_locale.save!
minneapolis_locale = Locale.find_or_initialize_by(name: 'Minneapolis')
minneapolis_locale.save!

# ---------------------------------------
# Team Members and Resource Assignements
# ---------------------------------------
dev1_team_member = TeamMember.find_or_initialize_by(email: 'dev1@deluxe.com')
dev1_team_member.locale = grand_rapids_locale
dev1_team_member.save!
ResourceAssignment.create!([team_member: dev1_team_member, resource_group: dev_resource_group])

dev2_team_member = TeamMember.find_or_initialize_by(email: 'dev2@bluemedora.com')
dev2_team_member.locale = minneapolis_locale
dev2_team_member.save!
resource_assignment = ResourceAssignment.find_or_initialize_by(team_member: dev2_team_member, resource_group: dev_resource_group)
resource_assignment.save!

qa1_team_member = TeamMember.find_or_initialize_by(email: 'qa1@bluemedora.com')
qa1_team_member.locale = grand_rapids_locale
qa1_team_member.save!
resource_assignment = ResourceAssignment.find_or_initialize_by(team_member: qa1_team_member, resource_group: qa_resource_group)
resource_assignment.save!

qa2_team_member = TeamMember.find_or_initialize_by(email: 'qa2@bluemedora.com')
qa2_team_member.locale = minneapolis_locale
qa2_team_member.save!
resource_assignment = ResourceAssignment.find_or_initialize_by(team_member: qa2_team_member, resource_group: qa_resource_group)
resource_assignment.save!

# ---------------------------------------
# Effort
# ---------------------------------------
def add_random_effort(team_member, effort_week, effort_buckets)
  remaining_effort = 5.0

  # Add Effort in Days
  effort_buckets.each_with_index do |bucket, index|
    next unless remaining_effort.positive?

    effort = index == (effort_buckets.size - 1) ? remaining_effort : Random.rand(0.1..remaining_effort).round(1)
    effort_entry = EffortEntry.new(team_member: team_member, effort_week: effort_week, effort_bucket: bucket, effort: effort)
    effort_entry.save!
    remaining_effort = (remaining_effort - effort).round(1)
  end
end

week_ending_at = DateTime.now.at_beginning_of_week - ((12 * 7) + 1).days

while week_ending_at <= DateTime.now
  effort_week = EffortWeek.find_or_initialize_by(ended_at: week_ending_at)
  effort_week.save!

  add_random_effort(dev1_team_member, effort_week, [physical_checks_bucket, electronic_checks_bucket, other_bucket])
  add_random_effort(dev2_team_member, effort_week, [physical_checks_bucket, electronic_checks_bucket, other_bucket])
  add_random_effort(qa1_team_member, effort_week, [physical_checks_bucket, electronic_checks_bucket, other_bucket])
  add_random_effort(qa2_team_member, effort_week, [physical_checks_bucket, electronic_checks_bucket, other_bucket])

  week_ending_at += 7.days
end
