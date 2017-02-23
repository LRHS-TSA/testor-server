require 'capybara/rspec'
require 'capybara/poltergeist'
require 'capybara-screenshot/rspec'
require 'support/capybara_macros.rb'
Capybara.default_max_wait_time = 4
Capybara.javascript_driver = :poltergeist
Capybara::Screenshot.prune_strategy = :keep_last_run
RSpec.configure do |config|
  config.include Warden::Test::Helpers, type: :feature
  config.include Capybara::DSL, type: :feature
  config.extend CapybaraMacros, type: :feature
  config.after :each, type: :feature do
    Warden.test_reset!
  end
end
