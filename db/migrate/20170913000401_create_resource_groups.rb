class CreateResourceGroups < ActiveRecord::Migration
  def change
    create_table :resource_groups do |t|
      t.string :name

      t.timestamps
    end
  end
end
