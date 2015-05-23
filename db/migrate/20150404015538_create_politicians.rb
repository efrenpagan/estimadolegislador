class CreatePoliticians < ActiveRecord::Migration
  def change
    create_table :politicians do |t|
      t.string :name
      t.string :position
      t.string :description
      t.string :role
      t.string :email
      t.string :political_party

      t.timestamps
    end
  end
end