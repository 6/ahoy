class UserOrganizationsController < ApplicationController
  before_filter :enforce_logged_in!

  def create
    @organization = organization
    @organization.users << User.find_by_email(user_organization_params[:email])
    redirect_to edit_organization_path(@organization), notice: "User added."
  end

  def destroy
    @organization = organization
    @user_organization = organization.user_organizations.find(params[:id])
    @user_organization.destroy!
    redirect_to edit_organization_path(@organization), notice: "Removed user."
  end

private

  def organization
    current_user.organizations.find(params[:organization_id])
  end

  def user_organization_params
    params.permit(:organization_id, :email)
  end
end
