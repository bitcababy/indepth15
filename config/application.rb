require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
# require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "active_resource/railtie"
require "sprockets/railtie"

# # require "rails/test_unit/railtie"

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module InDepth
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += %W(#{config.root}/extras)
    config.autoload_paths += %W(#{config.root}/app/models/ckeditor)

    # config.mongoid.observers = [:course_observer, :section_observer, :section_assignment_observer]
    # From http://bibwild.wordpress.com/2011/12/08/jquery-ui-css-and-images-and-rails-asset-pipeline/
    initializer :after_append_asset_paths, group: :all, after: :append_assets_paths do
      config.assets.paths.unshift Rails.root.join("app", "assets", "stylesheets", "screen", "images")
    end

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Eastern Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
		config.filter_parameters += [:password, :password_confirmation]

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    # Enforce whitelist mode for mass assignment.
    # This will create an empty whitelist of attributes available for mass-assignment for all models
    # in your app. As such, your models will need to explicitly whitelist or blacklist accessible
    # parameters by using an attr_accessible or attr_protected declaration.
    # config.active_record.whitelist_attributes = true

    # Enable the asset pipeline
    config.assets.enabled = true
		config.assets.initialize_on_precompile = false

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'
    
    config.active_support.deprecation = :notify

		config.generators do |g|
			g.helper_spec 				false
		  g.test_framework      :rspec, fixture: true
		  g.fixture_replacement :fabrication
		end

  end
end

# Mongoid.logger.level = Logger::WARN
# Moped.logger.level = Logger::WARN

class Array
	alias contains? include?
end

class Set 
  def mongoize
    self.to_a
  end
  
  class << self
    def demongoize(obj)
      Set.new obj
    end
    
    def mongoize(obj)
      case obj
      when Set then obj.mongoize
      else obj
      end
    end
    
    def evolve(obj)
      case object
      when Set then obj.mongoize
      else obj
      end
    end
  end
end

class SortedSet 
  def mongoize
    self.to_a
  end

  class << self
    def demongoize(obj)
      SortedSet.new obj
    end
    
    def mongoize(obj)
      case obj
      when SortedSet then obj.mongoize
      when Set then obj.mongoize
      else obj
      end
    end
    
    # def evolve(obj)
    #   case object
    #   when SortedSet then obj.mongoize
    #   else obj
    #   end
    # end
  end
end

  
