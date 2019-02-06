require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'vcr'
require 'webmock/rspec'
require 'figaro'

VCR.configure do |config|
  config.ignore_localhost = true
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.filter_sensitive_data("<YOUTUBE_API_KEY>") { ENV['YOUTUBE_API_KEY'] }
  config.filter_sensitive_data("<GITHUB_TOKEN>") { ENV['GITHUB_TOKEN'] }
  config.allow_http_connections_when_no_cassette = true
end

OmniAuth.config.test_mode = true
def stub_omniauth
  omniauth_hash = { 'provider' => 'github',
                    'uid' => '12345',
                    'credentials' => {
                      'token' => ENV["GITHUB_TOKEN"]
                      }
                    }
  OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(omniauth_hash)
end

def stub_get_json(url, filename)
  json_response = File.open("./spec/fixtures/#{filename}")
  stub_request(:get, url).
  to_return(status: 200, body: json_response)
end

ActiveRecord::Migration.maintain_test_schema!

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.javascript_driver = :selenium_chrome

Capybara.configure do |config|
  config.default_max_wait_time = 5
end

SimpleCov.start "rails"

Shoulda::Matchers.configure do |config|
    config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.include FactoryBot::Syntax::Methods

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end
