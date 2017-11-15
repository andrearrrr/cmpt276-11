class AddPrivateToPicks < ActiveRecord::Migration[5.1]
  def change
    add_column :picks, :private, :boolean
  end
end
