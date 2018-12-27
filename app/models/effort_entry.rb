class EffortEntry < ApplicationRecord
  belongs_to :team_member
  belongs_to :effort_bucket
  belongs_to :effort_week
end
