class ResumeUploader < CarrierWave::Uploader::Base
  include CarrierWave::UNOConv
  # Choose what kind of storage to use for this uploader:
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(pdf doc docx rtf odt)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    "CV-#{model.owner.display_name}-#{SecureRandom.hex(2)}".gsub(/\s/, '-') if original_filename
  end

end
