class CreateEffortEntries < ActiveRecord::Migration
  def change
    create_table :effort_entries do |t|
      t.decimal :effort, precision: 10, scale: 2
      t.references :team_member, foreign_key: true
      t.references :effort_bucket, foreign_key: true
      t.references :effort_week, foreign_key: true

      t.timestamps
    end
  end
end
