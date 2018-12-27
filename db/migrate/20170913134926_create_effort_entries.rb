class CreateEffortEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :effort_entries do |t|
      t.decimal :effort
      t.references :team_member, foreign_key: true
      t.references :effort_bucket, foreign_key: true
      t.references :effort_week, foreign_key: true

      t.timestamps
    end
  end
end
