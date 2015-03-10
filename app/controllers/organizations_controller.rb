class OrganizationsController < ApplicationController
  def show
    @organization = current_user!.organizations.find(params[:id])
  end

  def new
    @organization = Organization.new
  end

  def edit
    @organization = current_user!.organizations.find(params[:id])
    @user_organizations = @organization.user_organizations.includes(:user)
  end

  def create
    @organization = current_user!.organizations.build(organization_params)
    if @organization.save
      current_user!.organizations << @organization
      redirect_to @organization, notice: 'Organization was successfully created.'
    else
      render :new
    end
  end

  def update
    @organization = current_user!.organizations.find(params[:id])
    if @organization.update(organization_params)
      redirect_to @organization, notice: 'Organization was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @organization = current_user!.organizations.find(params[:id])
    if @organization.users.count > 1
      redirect_to edit_organization_path(@organization), notice: "Can't delete an organization with users."
    else
      @organization.destroy!
      redirect_to root_path, notice: 'Organization was successfully deleted.'
    end
  end

private

  def organization_params
    params.require(:organization).permit(:name, :twilio_account_sid, :twilio_auth_token)
  end
end
