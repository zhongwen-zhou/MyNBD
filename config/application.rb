require File.expand_path('../boot', __FILE__)

require 'rails/all'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module Nbd
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += %W(#{config.root}/lib/*)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = "Beijing" # Vincent: I know it's the default, I just like explicity
    
    config.active_record.default_timezone = :local #'Beijing'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :cn

    # JavaScript files you want as :defaults (application.js is always included).
    config.action_view.javascript_expansions[:defaults] = %w(jquery rails)

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]
    
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| "#{html_tag}".html_safe }

    #ActiveSupport::XmlMini.backend = 'Nokogiri'
    def mirror_redis_client
        @mirror_client ||= Redis.new(Redis::Factory.convert_to_redis_client_options(Settings.mirror_redis_page_cache_store))
    end    
  end
end
CLUB_EXP = /club/
NTT_EXP = /ntt/
WESTERN_EXP = /west/
WWW_EXP = /www|news|stock|company|life|bschool|finance|auto/
T_EXP = /t/
API_EXP = /api/
SUBDOMSIN_EXP = {NTT_EXP => "ntt", WESTERN_EXP => "west", WWW_EXP => "www", T_EXP => "t", API_EXP => "api", CLUB_EXP => "club"}
require 'patch/domain_route_patch'
require 'patch/simple_form_patch'
require 'patch/form_options_helper_patch'
require 'patch/query_method_patch'
require 'patch/redis_store_patch'
require 'patch/simple_captcha_patch'
require 'patch/date_select_helper_patch'
