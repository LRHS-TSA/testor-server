require 'devise'
require 'support/devise_macros.rb'
RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.extend DeviseMacros, type: :controller
end
