class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.from_omniauth!(request.env['omniauth.auth'])
    session[:current_user_id] = user.id
    redirect_to root_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  def failure
    redirect_to root_path, alert: "Authentication failed, please try again."
  end
end
