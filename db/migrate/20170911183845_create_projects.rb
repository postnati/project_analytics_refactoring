class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.references :dev_category, foreign_key: true

      t.string :name
      t.datetime :started_at
      t.datetime :stopped_at

      t.timestamps
    end
  end
end
