class EffortBucket < ApplicationRecord
  belongs_to :project
  belongs_to :effort_bucket_group
end
