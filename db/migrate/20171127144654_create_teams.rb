class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.integer :teamID
      t.string :abbreviation
      t.string :teamName
      t.string :simpleName
      t.string :location

      t.timestamps
    end
  end
end
