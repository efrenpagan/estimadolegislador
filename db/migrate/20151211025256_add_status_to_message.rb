class AddStatusToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :status, :string, default: "pending"
  end
end
