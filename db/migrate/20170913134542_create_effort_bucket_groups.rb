class CreateEffortBucketGroups < ActiveRecord::Migration
  def change
    create_table :effort_bucket_groups do |t|
      t.string :name

      t.timestamps
    end
  end
end
