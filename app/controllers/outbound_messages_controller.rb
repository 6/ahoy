class OutboundMessagesController < ApplicationController
  def create
    @outbound_message = current_organization.outbound_messages.new(outbound_message_params)
    @outbound_message.from_phone = current_organization.phone
    @outbound_message.sender_user = current_user!
    @outbound_message.save!
    redirect_to_back notice: "Message sent!"
  end

private

  def outbound_message_params
    params.require(:outbound_message).permit(:to_phone, :body)
  end
end
