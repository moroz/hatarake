class AvatarUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :auto_orient
  process resize_to_limit: [600,600]

  # Create different versions of your uploaded files:
  version :thumb do
    process :crop
    resize_to_fit(105,105)
  end

  version :normal do
    process :crop
    resize_to_fit(180,180)
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    Avatar::EXTENSIONS
  end

  def crop
    if model.crop_x.present?
      x = model.crop_x.to_i
      y = model.crop_y.to_i
      w = model.crop_w.to_i
      h = model.crop_h.to_i
      manipulate! do |img|
        img.crop("#{w}x#{h}+#{x}+#{y}")
        img
      end
    end
  end

  def auto_orient
    manipulate! do |img|
      img.tap(&:auto_orient)
    end
  end
end
