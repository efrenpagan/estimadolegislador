class CreateRepresentatives < ActiveRecord::Migration
  def change
    create_table :representatives do |t|
      t.references :district
      t.references :legislator, index: true, null: false
      t.integer :category, null: false

      t.timestamps
    end
  end
end
