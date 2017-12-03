class AddColumnToTeam < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :league_id, :integer
  end
end
