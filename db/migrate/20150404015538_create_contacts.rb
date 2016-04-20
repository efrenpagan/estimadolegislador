class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :position_type
      t.string :position_description
      t.string :internal_position
      t.string :email
      t.string :twitter_handle

      t.timestamps
    end
  end
end
