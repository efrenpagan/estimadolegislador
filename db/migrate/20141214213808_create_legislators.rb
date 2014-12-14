class CreateLegislators < ActiveRecord::Migration
  def change
    create_table :legislators do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.integer :role, null: false

      t.timestamps
    end
  end
end
