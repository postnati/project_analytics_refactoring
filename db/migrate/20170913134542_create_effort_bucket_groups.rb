class CreateEffortBucketGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :effort_bucket_groups do |t|
      t.string :name

      t.timestamps
    end
  end
end
