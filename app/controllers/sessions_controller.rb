class SessionsController < ApplicationController
  def new
    redirect_to after_login_path  if logged_in?
  end

  def create
    auth = request.env['omniauth.auth']
    if auth.info.email.match(/@(gmail|googlemail)\.com\z/)
      redirect_to new_session_path, alert: "Please log in with your work Google account (e.g. you@company.com)"
    else
      user = User.from_omniauth!(auth)
      session[:current_user_id] = user.id
      redirect_to after_login_path
    end
  end

  def destroy
    logout_user
  end

  def failure
    redirect_to new_session_path, alert: "Authentication failed, please try again."
  end

private

  def after_login_path
    if current_user!.reload.organization.present?
      customers_path
    else
      new_organization_path
    end
  end
end
