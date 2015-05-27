class CreateEmailPoliticians < ActiveRecord::Migration
  def change
    create_table :email_politicians do |t|
      t.integer :email_id
      t.integer :politician_id

      t.timestamps
    end
  end
end
