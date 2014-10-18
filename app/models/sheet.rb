class Sheet < ActiveRecord::Base
    belongs_to :user

    has_attached_file :image, :styles => {:large => "1188x769^", :medium => "680x440^", :small => "348x225^", :thumb => "170x110" }

    # validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

    #validates :image, presence: true
    validates :image, :attachment_presence => true
    validates :description, presence: true
    validates_with AttachmentContentTypeValidator, :attributes => :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
    validates_with AttachmentPresenceValidator, :attributes => :image
    validates_with AttachmentSizeValidator, :attributes => :image, :less_than => 1.megabytes
end
