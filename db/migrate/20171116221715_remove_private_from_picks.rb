class RemovePrivateFromPicks < ActiveRecord::Migration[5.1]
  def change
    remove_column :picks, :private, :boolean
  end
end
