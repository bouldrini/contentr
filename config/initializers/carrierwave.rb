ENV["AWS_ACCESS_KEY_ID"] = 'AKIAI4FBVCR52JJ5M2MA'
ENV["AWS_SECRET_ACCESS_KEY"] = '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'
ENV["AWS_S3_BUCKET"] = 'koehlers-landgasthaus'

CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => ENV["AWS_ACCESS_KEY_ID"],
    :aws_secret_access_key  => ENV["AWS_SECRET_ACCESS_KEY"]
  }
  config.fog_directory  = ENV["AWS_S3_BUCKET"]
end
