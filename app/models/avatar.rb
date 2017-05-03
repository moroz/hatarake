class Avatar < ApplicationRecord
  belongs_to :user
  has_attached_file :image, styles: { original: '600x600>', avatar: '164x164#', thumb: '100x100#' }
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
