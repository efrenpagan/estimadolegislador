class AddAttachmentImageToLegislators < ActiveRecord::Migration
  def self.up
    change_table :legislators do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :legislators, :image
  end
end
