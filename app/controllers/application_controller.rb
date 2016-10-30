# Base controller class
class ApplicationController < ActionController::Base
  protect_from_forgery with: :reset_session
  before_action :configure_permitted_parameters, if: :devise_controller?
  check_authorization unless: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role, :name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
