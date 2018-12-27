class ResourceGroup < ApplicationRecord
  has_many :resource_assignments
  has_many :team_members, through: :resource_assignments
end
