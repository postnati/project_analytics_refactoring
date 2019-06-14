# frozen_string_literal: true

FactoryBot.define do
  factory :resource_assignment do
    team_member { nil }
    resource_group { nil }
    started_at { '2018-12-28 03:12:32' }
    stopped_at { '2018-12-28 03:12:32' }
  end
end
