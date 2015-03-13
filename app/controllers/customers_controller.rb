class CustomersController < ApplicationController
  before_filter :enforce_logged_in!

  def index
    scope = current_organization.customers.includes(:messages).order(updated_at: :desc)
    @count = scope.count
    @customers = scope.page(page_default_first).per(50)
    @outbound_message = OutboundMessage.new
  end

  def show
    @customer = current_organization.customers.find(params[:id])
    @messages = (@customer.inbound_messages + @customer.outbound_messages).sort_by(&:created_at).reverse
    @outbound_message = OutboundMessage.new
  end

  def update
    @customer = current_organization.customers.find(params[:id])
    @customer.update_attributes!(customer_params)
    redirect_to customer_path(@customer), notice: "Saved!"
  end

private

  def customer_params
    params.require(:customer).permit(:name, :email)
  end
end
