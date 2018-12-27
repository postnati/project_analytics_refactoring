class EffortBucket < ApplicationRecord
  belongs_to :project, optional: true
  belongs_to :effort_bucket_group
end
