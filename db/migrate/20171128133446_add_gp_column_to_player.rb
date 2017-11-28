class AddGpColumnToPlayer < ActiveRecord::Migration[5.1]
  def change
    add_column :players, :GP, :integer
  end
end
