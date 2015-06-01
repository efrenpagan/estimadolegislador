class CreateRecipients < ActiveRecord::Migration
  def change
    create_table :recipients do |t|
      t.uuid :email_id
      t.integer :politician_id

      t.timestamps
    end
  end
end
