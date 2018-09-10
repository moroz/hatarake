# frozen_string_literal: true

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
    Resume::EXTENSIONS
  end

  version :pdf, if: :not_pdf? do
    process uno_convert: 'pdf'
    def full_filename(for_file = model.file)
      for_file.sub(/\.\w{2,4}$/, '.pdf')
    end
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    model.filename + ".#{file.extension}" if original_filename
  end

  protected

  def not_pdf?(new_file)
    new_file.content_type != 'application/pdf'
  end
end
