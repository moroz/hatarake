class Avatar < Attachment
  mount_uploader :file, AvatarUploader

  belongs_to :owner, class_name: "User", dependent: :destroy

  MAX_SIZE = 5242880 # 5 megabytes
  EXTENSIONS = %w(jpg jpeg gif png svg)

  validates :file, file_size: { less_than_or_equal_to: MAX_SIZE }

  # For cropping
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :crop_avatar

  def crop_avatar
    file.recreate_versions! if crop_x.present?
  end  

  def vector?
    !croppable?
  end

  def croppable?
    file.content_type != 'image/svg+xml'
  end
end
