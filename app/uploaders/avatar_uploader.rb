# frozen_string_literal: true

class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :auto_orient
  process resize_to_limit: [600, 600]

  version :thumb do
    process :crop
    resize_to_fit(105, 105)
  end

  version :normal do
    process :crop
    resize_to_fit(180, 180)
  end

  def extension_whitelist
    Avatar::EXTENSIONS
  end

  def crop
    return unless model.crop_x.present?
    x = model.crop_x.to_i
    y = model.crop_y.to_i
    w = model.crop_w.to_i
    h = model.crop_h.to_i
    manipulate! do |img|
      img.crop("#{w}x#{h}+#{x}+#{y}")
      img
    end
  end

  def auto_orient
    manipulate! do |img|
      img.tap(&:auto_orient)
    end
  end
end
