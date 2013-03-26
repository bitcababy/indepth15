CarrierWave.configure do |config|
  if Rails.env.production?
   config.cloud_files_user_name = 'mer'
   config.cloud_files_api_key = '17b1fba2e589dd68a75040f7b963b343'
   config.cloud_files_container = 'whs'
 end
end
  