# Base controller class
class ApplicationController < ActionController::Base
  respond_to :html, :json

  protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?
  acts_as_token_authentication_handler_for User, if: ->(controller) { controller.user_token_authenticable? }
  check_authorization unless: :devise_controller?

  rescue_from CanCan::AccessDenied do
    head :forbidden
  end

  protected

  def user_token_authenticable?
    request.format.json?
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role, :name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
