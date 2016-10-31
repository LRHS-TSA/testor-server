require 'devise'
RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.extend DeviseMacros, type: :controller
end
