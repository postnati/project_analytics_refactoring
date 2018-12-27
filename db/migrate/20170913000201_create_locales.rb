class CreateLocales < ActiveRecord::Migration[5.1]
  def change
    create_table :locales do |t|
      t.string :name

      t.timestamps
    end
  end
end
