class Attachment < ApplicationRecord
  belongs_to :owner, class_name: "User"
  mount_uploader :file, AttachmentUploader
end
