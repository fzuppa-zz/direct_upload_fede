unless ENV['S3_BUCKET_NAME'].blank?
  AMAZON_S3_CREDENTIALS = {:bucket => ENV['S3_BUCKET_NAME'],
                           :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
                           :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']}
else
  AMAZON_S3_CREDENTIALS = YAML.load_file("#{::Rails.root}/config/s3.yml")[::Rails.env]
end