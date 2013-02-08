require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'email_spec'
  require 'rspec/autorun'
  require 'capybara/rspec'
  require 'devise/test_helpers'
  require 'mongoid-history'

  class HistoryTracker
    include Mongoid::History::Tracker
  end

  module Devise
    module Models
      module DatabaseAuthenticatable
        protected

        def password_digest(password)
          password
        end
      end
    end
  end

  # Devise.setup do |config|
  #   config.stretches = 1
  # end


  include Utils

  Capybara.configure do |c|
  	c.default_driver = :rack_test
  	c.javascript_driver = :webkit
  	c.default_selector = :css
    c.default_wait_time = 5
  end

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("app/lib/extras/**/*.rb")].each {|f| require f}


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
    config.include(EmailSpec::Helpers)
    config.include(EmailSpec::Matchers)
    config.include Devise::TestHelpers, :type => :controller
    config.include Devise::TestHelpers, :type => :view

    DatabaseCleaner.orm = "mongoid"

    require 'database_cleaner'
    config.before :suite do
      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.orm = 'mongoid'
    end
  	# Clear out 
  	config.before(:each) do
  		DatabaseCleaner.clean
      Warden.test_mode!
      Mongoid::IdentityMap.clear
  	end
    
    config.after(:each) do
      Warden.test_reset!
    end

  end
end

Spork.each_run do
  # This code will be run each time you run your specs.
  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("app/lib/extras/**/*.rb")].each {|f| require f}
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  # if( ENV['COVERAGE'] == 'on' )
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
  # end
end

