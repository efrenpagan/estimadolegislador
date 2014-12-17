class CreateLegislators < ActiveRecord::Migration
  def change
    create_table :legislators do |t|
      t.string :name
      t.string :email
      t.integer :role

      t.timestamps
    end
  end
end
