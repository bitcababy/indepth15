# AssetSync.configure do |config|
#   config.fog_provider = 'Rackspace'
#   config.rackspace_username ='mer'
#   config.rackspace_api_key = '17b1fba2e589dd68a75040f7b963b343'
#
#   # if you need to change rackspace_auth_url (e.g. if you need to use Rackspace London)
#   # config.rackspace_auth_url = "lon.auth.api.rackspacecloud.com"
#   config.fog_directory = 'whsmd2'
#
#   # Invalidate a file on a cdn after uploading files
#   # config.cdn_distribution_id = "12345"
#   # config.invalidate = ['file1.js']
#
#   # Increase upload performance by configuring your region
#   # config.fog_region = 'eu-west-1'
#   #
#   # Don't delete files from the store
#   # config.existing_remote_files = "keep"
#   #
#   # Automatically replace files with their equivalent gzip compressed version
#   # config.gzip_compression = true
#   #
#   # Use the Rails generated 'manifest.yml' file to produce the list of files to
#   # upload instead of searching the assets directory.
#   # config.manifest = true
#   #
#   # Fail silently.  Useful for environments such as Heroku
#   config.fail_silently = true
# end
