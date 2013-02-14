CarrierWave.configure do |config|
  if Rails.env.production?
   config.cloud_files_user_name = 'xxxxxx'
   config.cloud_files_api_key = 'xxxxxxxxxxxxxxxxxxxxx'
   config.cloud_files_container = 'name_of_bucket'
 end
end
  