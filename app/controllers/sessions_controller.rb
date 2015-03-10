class SessionsController < ApplicationController
  def new
    if current_user
      if current_user.organizations.present?
        redirect_to organization_path(current_user.organizations.first)
      else
        redirect_to new_organization_path
      end
    end
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
