class CreateLegislators < ActiveRecord::Migration
  def change
    create_table :legislators do |t|
      t.string :name
      t.string :branch
      t.string :email
      t.string :position
      t.string :district
      t.string :political_party

      t.timestamps
    end
  end
end
