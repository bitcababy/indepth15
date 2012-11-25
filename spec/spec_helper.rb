if( ENV['COVERAGE'] == 'on' )
  require 'simplecov'
  require 'simplecov-rcov'
  class SimpleCov::Formatter::MergedFormatter
    def format(result)
       SimpleCov::Formatter::HTMLFormatter.new.format(result)
       SimpleCov::Formatter::RcovFormatter.new.format(result)
    end
  end
  SimpleCov.formatter = SimpleCov::Formatter::MergedFormatter
  SimpleCov.start 'rails' do
  	add_filter '/spec/'
  	add_filter '/features/'
    add_filter '/config/'
    add_filter '/uploaders/'
    add_filter '/app/models/ckeditor/'
  end
end

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'email_spec'
require 'rspec/autorun'
require 'capybara/rspec'
require 'devise/test_helpers'

include Utils

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
Dir[Rails.root.join("app/lib/extras/**/*.rb")].each {|f| require f}

require 'database_cleaner'
DatabaseCleaner.strategy = :truncation


RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false
	config.include Mongoid::Matchers
	config.include Devise::TestHelpers, :type => :controller
  config.include(EmailSpec::Helpers)
  config.include(EmailSpec::Matchers)

	# Clear out 
	config.before(:each) do
		DatabaseCleaner.clean
		Mongoid::IdentityMap.clear
	end
	
	config.after(:each) do
		DatabaseCleaner.clean
	end
	
	# Devise
	config.include Devise::TestHelpers, :type => :controller
	config.include Devise::TestHelpers, :type => :view
	config.include Devise::TestHelpers, :type => :helper
	config.extend ControllerMacros, :type => :controller

end
require 'mocha/setup'

