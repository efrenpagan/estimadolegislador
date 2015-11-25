class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages, id: :uuid do |t|
      t.string :from_name
      t.string :from_email
      t.string :subject
      t.text :body_html
      t.text :body_text
      t.boolean :is_public
      t.string :short_url

      t.timestamps
    end
  end
end
