require 'capybara/rspec'
require 'support/capybara_macros.rb'
Capybara.default_max_wait_time = 4
RSpec.configure do |config|
  config.include Warden::Test::Helpers, type: :feature
  config.extend CapybaraMacros, type: :feature
  config.after :each, type: :feature do
    Warden.test_reset!
  end
end
