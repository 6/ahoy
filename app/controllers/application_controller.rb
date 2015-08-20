class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :current_organization, :logged_in?

  class Unauthorized < Exception
  end

  rescue_from Unauthorized do |exception|
    logout_user
  end

  def current_user
    @current_user ||= User.includes(:organization).find(session[:current_user_id])  if session[:current_user_id]
  end

  def current_organization
    current_user!.organization
  end

  def current_user!
    current_user or raise Unauthorized
  end

  def enforce_logged_in!
    redirect_to new_session_path  unless logged_in?
  end

  def logged_in?
    current_user.present?
  end

  def logout_user
    reset_session
    redirect_to new_session_path
  end

  def page_default_first
    [(params[:page].andand.to_i || 1), 1].max
  end
  hide_action :page_default_first

  def redirect_to_back(options = {})
    if !request.env["HTTP_REFERER"].blank? and request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
      redirect_to :back, options
    else
      redirect_to '/', options
    end
  end
end
