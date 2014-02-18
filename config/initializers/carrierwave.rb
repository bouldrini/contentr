ENV["AWS_ACCESS_KEY_ID"] = 'AKIAJ7ODXQVCP7YS6RUQ'
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
