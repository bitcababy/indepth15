# per https://github.com/carrierwaveuploader/carrierwave/wiki/How-to%3A-Make-Carrierwave-work-on-Heroku

CarrierWave.configure do |config|
  config.root = Rails.root.join('tmp')
  # config.cache_dir = '/carrierwave'
  # This is needed for Heroku, maybe
  config.cache_dir = "uploads"

  config.fog_credentials = {
    provider: 'Rackspace',
    rackspace_username: 'mer',
    rackspace_api_key: '17b1fba2e589dd68a75040f7b963b343',
    rackspace_region: :dfw
  }
  config.fog_directory = 'whsmd'
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
  config.fog_public     = false
  config.asset_host = 'http://files.westonmath.org'
end
