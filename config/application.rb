require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
require_relative '../lib/smtp_pool_delivery'

module SjaaMembers
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w(assets tasks))
    config.autoload_paths += %W(#{config.root}/app/services)
    config.eager_load_paths += %W(#{config.root}/app/services)

    # Propshaft config
    #config.assets = ActiveSupport::OrderedOptions.new
    #config.assets.paths = [Rails.root.join("app/assets")]
    config.assets.paths << Rails.root.join("app/javascript")

    # Use app-based auth for mission control
    config.mission_control.jobs.http_basic_auth_enabled = false

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end

  DEFAULT_MEMBERSHIP_TERM = 12
  YEARLY_MEMBERSHIP_RATE = 20
  EPHEMERIS_FEE = 10
end
