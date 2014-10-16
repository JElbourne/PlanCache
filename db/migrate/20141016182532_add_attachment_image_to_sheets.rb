class AddAttachmentImageToSheets < ActiveRecord::Migration
  def self.up
    change_table :sheets do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :sheets, :image
  end
end
