class AddPasswordToUsers < ActiveRecord::Migration[5.1]
  #add a column in users table called password_digest, or "hashed password"
  def change
    add_column :users, :password_digest, :string
  end
end
