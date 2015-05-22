class AddAttachmentImageToPoliticians < ActiveRecord::Migration
  def self.up
    change_table :politicians do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :politicians, :image
  end
end
