# Base controller class
class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?
  acts_as_token_authentication_handler_for User
  check_authorization unless: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role, :name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
