class AddIsPrivateToPicks < ActiveRecord::Migration[5.1]
  def change
    add_column :picks, :is_private, :boolean
  end
end
