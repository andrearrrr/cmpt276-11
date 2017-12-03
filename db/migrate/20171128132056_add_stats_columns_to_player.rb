class AddStatsColumnsToPlayer < ActiveRecord::Migration[5.1]
  def change
    add_column :players, :PTS, :float
    add_column :players, :REB, :float
    add_column :players, :AST, :float
    add_column :players, :NET_RATING, :float
    add_column :players, :TS_PCT, :float
    add_column :players, :USG_PCT, :float
  end
end
