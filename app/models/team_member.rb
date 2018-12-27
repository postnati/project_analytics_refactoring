class TeamMember < ApplicationRecord
  has_many :resource_assignments
  has_many :resource_groups, through: :resource_assignments
  belongs_to :locale, optional: true
end
