source 'https://rubygems.org'

#ruby=ruby-2.2.1
#ruby-gemset=indepth12


gem 'rails', '>= 3.2.6', '<4.0.0'
gem 'actionmailer'
gem 'railties'

group :production do
  gem 'rails_12factor'
  gem 'rails_serve_static_assets'
end

gem 'sass-rails'#,   '~> 3.2.3'
gem 'coffee-rails'#, '~> 3.2.1'

gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'jquery-ui-sass-rails', git: 'git://github.com/bitcababy/jquery-ui-sass-rails.git'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier'#, '>= 1.0.3'

  gem 'turbo-sprockets-rails3'

gem 'browser'
gem 'asset_sync'
gem 'puma'
gem 'strong_parameters'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

gem 'bundler'

## Mongoid
gem 'mongo'
gem 'mongoid'
gem 'bson_ext'

# gem 'mongoid-history'
# gem 'mongoid-data_table', path: 'lib/plugins/mongoid-data_table'
# gem 'mongoid_rails_migrations'
# gem 'delayed_job_mongoid', :git => 'git://github.com/asavartsov/delayed_job_mongoid.git'
# gem 'mongoid-cached-json'
# gem 'mongodb_fulltext_search'

gem 'devise'
gem 'haml'
gem 'htmlentities'
gem 'google-webfonts'


# Client side validations
gem 'client_side_validations'
gem 'client_side_validations-mongoid'
gem 'client_side_validations-simple_form'

gem 'validates_email_format_of'

gem 'simple_form'
gem 'memcache-client'
gem 'settingslogic'#, :git => 'git://github.com/bitcababy/settingslogic.git'
# gem 'kaminari'

gem 'ckeditor'#, '~> 4.0.0'

# Uploads
gem 'carrierwave'
gem 'carrierwave-mongoid', :require => 'carrierwave/mongoid'
gem 'fog'
gem 'mini_magick'

gem 'tidy_ffi'
gem 'daemons'
gem 'pry'

gem 'yard'

# gem "activeadmin-mongoid",  git: "git://github.com/elia/activeadmin-mongoid.git"

group :development, :test do
  gem 'taps'
  gem 'launchy'
  gem 'rspec-rails'
  gem 'rspec-formatter-webkit'
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-bundler'
  gem 'fabrication'#, '>= 2.0'
  gem 'foreman'
# gem 'perftools.rb', :git => 'git://github.com/tmm1/perftools.rb.git'
  # To use debugger
  # gem 'inherited_resources'
end

group :development do
	gem 'haml-rails'
end

group :test do
	gem 'rspec-instafail'
	gem 'mongoid-rspec'
  gem 'rspec-html-matchers'
  gem 'rspec-given'
	gem 'capybara'
	gem 'database_cleaner'
  gem 'capybara-webkit'
	gem 'hpricot'
	gem 'simplecov', :require => false
  gem 'simplecov-rcov', :require => false
	gem 'email_spec'
  gem 'websocket'
  gem 'rb-fsevent'#, '~>0.9.1'
end
