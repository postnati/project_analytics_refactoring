# frozen_string_literal: true

FactoryBot.define do
  factory :effort_entry do
    effort { '9.99' }
    team_member { nil }
    effort_bucket { nil }
    effort_week { nil }
  end
end
