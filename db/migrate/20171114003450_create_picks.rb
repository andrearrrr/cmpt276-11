class CreatePicks < ActiveRecord::Migration[5.1]
  def change
    create_table :picks do |t|
      t.integer :user_id
      t.integer :player_id
      t.integer :award_id
      t.integer :season

      t.timestamps
    end
  end
end
