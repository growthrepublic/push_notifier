ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec_loader'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include RequestHelpers, type: :request
  config.order = 'random'
  config.use_transactional_fixtures = false

  config.before(:each) do
    Mongoid.purge!
  end
end
