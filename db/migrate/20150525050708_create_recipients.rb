class CreateRecipients < ActiveRecord::Migration
  def change
    create_table :recipients do |t|
      t.uuid :message_id
      t.integer :contact_id

      t.timestamps
    end
  end
end
