class OrganizationsController < ApplicationController
  def new
    redirect_to edit_organization_path  if current_user!.organization.present?
    @organization = Organization.new
  end

  def edit
    @organization = current_user!.organization
  end

  def create
    @organization = Organization.new(organization_params.merge({
      email_domain: current_user!.email_domain,
    }))
    if @organization.save
      @organization.users << current_user
      redirect_to customers_path, notice: 'Organization was successfully created.'
    else
      render :new
    end
  end

  def update
    @organization = current_user!.organization
    if @organization.update(organization_params)
      redirect_to edit_organization_path, notice: 'Organization was successfully updated.'
    else
      render :edit
    end
  end

private

  def organization_params
    params.require(:organization).permit(:name, :twilio_account_sid, :twilio_auth_token)
  end
end
