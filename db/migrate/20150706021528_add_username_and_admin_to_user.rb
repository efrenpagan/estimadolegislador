class AddUsernameAndAdminToUser < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_index :users, :username, unique: true
    add_column :users, :admin, :boolean, default: false
  end
end
