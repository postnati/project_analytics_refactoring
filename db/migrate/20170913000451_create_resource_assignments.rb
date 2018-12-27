class CreateResourceAssignments < ActiveRecord::Migration[5.1]
  def change
    create_table :resource_assignments do |t|
      t.references :team_member, foreign_key: true
      t.references :resource_group, foreign_key: true
      t.datetime :started_at
      t.datetime :stopped_at

      t.timestamps
    end
  end
end
