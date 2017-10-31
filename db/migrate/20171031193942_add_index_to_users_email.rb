class AddIndexToUsersEmail < ActiveRecord::Migration[5.1]

    #add an index to the users table in the database stating that the email column
    #must be unique
    def change
    add_index :users, :email, unique: true
    end

end
