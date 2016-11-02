# Controller for static pages
class PagesController < ApplicationController
  respond_to :html

  skip_authorization_check

  protected

  def user_token_authenticable?
    false
  end
end
