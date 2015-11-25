class AddAttachmentImageToContacts < ActiveRecord::Migration
  def self.up
    change_table :contacts do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :contacts, :image
  end
end
