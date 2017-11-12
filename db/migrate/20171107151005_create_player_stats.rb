class CreatePlayerStats < ActiveRecord::Migration[5.1]
  def change
    create_table :player_stats do |t|
      t.integer :player_id
      t.integer :season
      t.integer :age
      t.string :team
      t.integer :games
      t.integer :games_started
      t.float :minutes
      t.float :fg
      t.float :fga
      t.float :fgpct
      t.float :fg3
      t.float :fg3a
      t.float :fg3pct
      t.float :efgpct
      t.float :ft
      t.float :fta
      t.float :ftpct
      t.float :reboff
      t.float :rebdef
      t.float :rebtot
      t.float :assists
      t.float :steals
      t.float :blocks
      t.float :tovs
      t.float :points
      t.float :per
      t.float :tspct
      t.float :usage
      t.float :obpm
      t.float :dbpm
      t.float :bpm
      t.float :vorp

      t.timestamps
    end
  end
end
