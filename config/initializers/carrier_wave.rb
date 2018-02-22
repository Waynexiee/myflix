CarrierWave.configure do |config|
  if Rails.env.staging? || Rails.env.production?
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['S3_KEY'],
      aws_secret_access_key: ENV['S3_SECRET'],
      region: ENV['S3_REGION'],
      :path_style => true
    }
    config.storage = :fog
    config.fog_directory    = ENV['S3_BUCKET_NAME']
    config.fog_public = true                         # Generate http:// urls. Defaults to :authenticated_read (https://)
    config.asset_host         = ENV['S3_ASSET_URL']
  else
    config.storage = :file
    config.enable_processing = Rails.env.development?
  end

  config.cache_dir = "#{Rails.root}/tmp/uploads"                  # To let CarrierWave work on heroku

end