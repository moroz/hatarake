class Attachment < ApplicationRecord
  belongs_to :owner, class_name: "User", required: true
  validates_presence_of :file

  mount_uploader :file, AttachmentUploader
end
