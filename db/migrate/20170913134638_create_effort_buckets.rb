class CreateEffortBuckets < ActiveRecord::Migration[5.1]
  def change
    create_table :effort_buckets do |t|
      t.string :name
      t.references :project, foreign_key: true
      t.references :effort_bucket_group, foreign_key: true

      t.timestamps
    end
  end
end
