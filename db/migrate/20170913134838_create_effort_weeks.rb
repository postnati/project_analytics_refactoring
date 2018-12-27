class CreateEffortWeeks < ActiveRecord::Migration[5.1]
  def change
    create_table :effort_weeks do |t|
      t.datetime :ended_at

      t.timestamps
    end
  end
end
