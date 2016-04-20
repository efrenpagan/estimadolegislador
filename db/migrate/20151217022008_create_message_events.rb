class CreateMessageEvents < ActiveRecord::Migration
  def change
    create_table :message_events do |t|
      t.string :event
      t.references :recipient, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
