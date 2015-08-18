class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :current_organization

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
    redirect_to root_path  unless current_user
  end

  def logout_user
    reset_session
    redirect_to root_path
  end

  def handle_current_user!
    if !current_user.organization.present?
      if organization = Organization.find_by_email_domain(current_user.email_domain)
        organization.users << current_user
      else
        redirect_to new_organization_path
      end
    end
    if current_user.reload.organization.present?
      redirect_to customers_path
    end
  end

  def page_default_first
    [(params[:page].andand.to_i || 1), 1].max
  end
  hide_action :page_default_first

  def redirect_to_back(options = {})
    if !request.env["HTTP_REFERER"].blank? and request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
      redirect_to :back, options
    else
      redirect_to root_path, options
    end
  end
end
