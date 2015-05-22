class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails, id: :uuid do |t|
      t.string :from_name
      t.string :from_email
      t.string :subject
      t.string :message
      t.boolean :is_public
      t.string :short_url
      t.integer :politician_id

      t.timestamps
    end
  end
end
