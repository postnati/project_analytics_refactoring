class ResourceAssignment < ApplicationRecord
  belongs_to :team_member
  belongs_to :resource_group
end
