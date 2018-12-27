class Project < ApplicationRecord
  belongs_to :dev_category
  has_many :pivotal_projects
  has_many :effort_buckets
end
