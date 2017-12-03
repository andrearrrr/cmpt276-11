class AddColumnsToPlayer < ActiveRecord::Migration[5.1]
  def change
    add_column :players, :PERSON_ID, :integer
    add_column :players, :DISPLAY_LAST_COMMA_FIRST, :string
    add_column :players, :DISPLAY_FIRST_LAST, :string
    add_column :players, :FROM_YEAR, :string
    add_column :players, :TO_YEAR, :string
    add_column :players, :PLAYERCODE, :string
    add_column :players, :TEAM_ID, :integer
    add_column :players, :TEAM_CITY, :string
    add_column :players, :TEAM_NAME, :string
    add_column :players, :TEAM_ABBREVIATION, :string
    add_column :players, :TEAM_CODE, :string
  end
end
