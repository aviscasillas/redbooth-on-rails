require 'redbooth_on_rails/external_api'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !current_user.nil?
  end

  def authenticate
    redirect_to root_url unless logged_in?
  end

  private

  def external_api
    @external_api ||= RedboothOnRails::ExternalApi.new(current_user)
  end
end
