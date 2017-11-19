class CreateFriendships < ActiveRecord::Migration[5.1]
  def change
    create_table :friendships do |t|
      t.integer :send_id
      t.integer :recieve_id

      t.timestamps
    end
    add_index :friendships, :send_id
    add_index :friendships, :recieve_id
    add_index :friendships, [:send_id, :recieve_id], unique: true
  end
end
