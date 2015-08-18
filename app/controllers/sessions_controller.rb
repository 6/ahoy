class SessionsController < ApplicationController
  def new
    handle_current_user!  if current_user
  end

  def create
    auth = request.env['omniauth.auth']
    if auth.info.email.match(/@(gmail|googlemail)\.com\z/)
      redirect_to root_path, alert: "Please log in with your work Google account (e.g. you@company.com)"
    else
      user = User.from_omniauth!(auth)
      session[:current_user_id] = user.id
      redirect_to root_path
    end
  end

  def destroy
    logout_user
  end

  def failure
    redirect_to root_path, alert: "Authentication failed, please try again."
  end
end
