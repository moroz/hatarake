# frozen_string_literal: true

CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'                        # required
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     Rails.application.secrets.AWS_ACCESS_KEY_ID, # required
    aws_secret_access_key: Rails.application.secrets.AWS_SECRET_ACCESS_KEY, # required
    region:                Rails.application.secrets.AWS_REGION, # optional, defaults to 'us-east-1'
  }

  # For testing, upload files to local `tmp` folder.
  if Rails.env.test? || Rails.env.cucumber?
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/tmp"
  else
    config.storage = :fog
  end

  config.cache_dir = "#{Rails.root}/tmp/uploads" # To let CarrierWave work on heroku

  config.fog_directory = Rails.application.secrets.s3_bucket # required

  # config.fog_attributes = { cache_control: "public, max-age=#{365.day.to_i}" } # optional, defaults to {}
end
