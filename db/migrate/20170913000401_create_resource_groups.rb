class CreateResourceGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :resource_groups do |t|
      t.string :name

      t.timestamps
    end
  end
end
