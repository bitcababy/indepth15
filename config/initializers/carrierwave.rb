CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'Rackspace',
    rackspace_user_name: 'mer',
    rackspace_api_key: '17b1fba2e589dd68a75040f7b963b343',
    cloud_files_container: 'whs'
  }
  config.fog_directory = 'whs'
  config.asset_host = 'http://10e290356935c22c22a0-f9599cd593310f23e69703ca2d9a6168.r44.cf2.rackcdn.com/config.js'
end

