class AddMoreColumnsToPlayer < ActiveRecord::Migration[5.1]
  def change
    add_column :players, :AGE, :integer
    add_column :players, :PLAYER_HEIGHT, :string
    add_column :players, :PLAYER_WEIGHT, :string
    add_column :players, :COLLEGE, :string
    add_column :players, :COUNTRY, :string
    add_column :players, :DRAFT_YEAR, :string
    add_column :players, :DRAFT_ROUND, :string
    add_column :players, :DRAFT_NUMBER, :string
  end
end
