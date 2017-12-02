class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.string :name
      t.bigint :owner_id
      t.timestamps
    end


    create_table :memberships do |t|
      t.belongs_to :group, index: true
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
