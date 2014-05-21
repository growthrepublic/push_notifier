require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PushNotifier
  class Application < Rails::Application
    config.i18n.enforce_available_locales = false

    config.generators do |g|
      g.fixture_replacement :factory_girl
      g.test_framework :rspec,
        helper_specs: false,
        view_specs: false,
        routing_specs: false
    end
  end
end
