class CreateSenators < ActiveRecord::Migration
  def change
    create_table :senators do |t|
      t.integer :type, null: false
      t.references :district, index: true, null: false

      t.timestamps
    end
  end
end
