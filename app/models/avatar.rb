class Avatar < Attachment
  mount_uploader :file, AvatarUploader

  belongs_to :owner, class_name: "User"

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
