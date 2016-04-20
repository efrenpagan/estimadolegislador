class AddDefaultValueToMessagesIsPublic < ActiveRecord::Migration
  def change
    change_column :messages, :is_public, :boolean, :default => false
  end
end
