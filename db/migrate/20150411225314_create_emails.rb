class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails, id: :uuid do |t|
      t.string :from_name
      t.string :from_email
      t.string :subject
      t.text :message_html
      t.text :message_text
      t.boolean :is_public
      t.string :short_url

      t.timestamps
    end
  end
end
