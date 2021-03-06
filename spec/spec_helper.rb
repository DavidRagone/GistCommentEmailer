require 'simplecov'
SimpleCov.start 'rails'
require 'rubygems'
require 'spork'
#uncomment the following line to use spork with the debugger
##require 'spork/ext/ruby-debug'
#
Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'capybara/rspec'
  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
  RSpec.configure do |config|
    # ## Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr
    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    #config.fixture_path = "#{::Rails.root}/spec/factories"
    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = true
    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false
  end

  env_vars = File.join(Rails.root, 'config', 'env_vars.rb')
  load(env_vars) if File.exists?(env_vars)

  Capybara.default_host = 'http://example.org'

  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(:github, Hashie::Mash.new(
      uid: "12345",
      credentials: Hashie::Mash.new(token: "abc123"),
      info: Hashie::Mash.new(
        name: "Mister Bob",
        email: '',
        image: "http://placekitten.com/200/300"
      )
    )
  )

  Spork.each_run do
    # This code will be run each time you run your specs.
  end
end
