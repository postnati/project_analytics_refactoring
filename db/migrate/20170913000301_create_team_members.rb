class CreateTeamMembers < ActiveRecord::Migration
  def change
    create_table :team_members do |t|
      t.string :email

      t.references :locale, foreign_key: true

      t.timestamps
    end
  end
end
