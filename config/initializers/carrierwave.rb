# per https://github.com/carrierwaveuploader/carrierwave/wiki/How-to%3A-Make-Carrierwave-work-on-Heroku

CarrierWave.configure do |config|
  config.root = Rails.root.join('tmp')
  config.cache_dir = '/carrierwave'
  # config.cache_dir = '/carrierwave'
  # This is needed for Heroku, maybe
  config.cache_dir = "uploads"

  config.fog_credentials = {
    provider: 'Rackspace',
    rackspace_username: 'mer',
    rackspace_api_key: '17b1fba2e589dd68a75040f7b963b343',
  }
  config.fog_directory = 'whsmd'
  config.asset_host = 'http://files.westonmath.org'
  # config.asset_host = 'https://bace7f7158181dd9d70a-5a9101a0fdfe9adb52a508fedafcfb04.r0.cf1.rackcdn.com'
end
