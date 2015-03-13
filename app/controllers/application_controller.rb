class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  force_ssl if: :ssl_configured?

  def current_user
    @current_user ||= User.includes(:organization).find(session[:current_user_id])  if session[:current_user_id]
  end

  def current_user!
    current_user or redirect_to root_path
  end

  def enforce_logged_in!
    redirect_to root_path  unless current_user
  end

  def ssl_configured?
    !Rails.env.development?
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
      redirect_to edit_organization_path(current_user.organization)
    end
  end
end
