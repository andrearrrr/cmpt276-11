class AddDescriptionToAwards < ActiveRecord::Migration[5.1]
  def change
    add_column :awards, :description, :string
  end
end
