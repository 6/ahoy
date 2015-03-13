class OutboundMessagesController < ApplicationController
  include TwilioMixin

  def create
    @outbound_message = current_organization.outbound_messages.new(outbound_message_params)
    @outbound_message.from_phone = current_organization.phone
    @outbound_message.sender_user = current_user!
    @outbound_message.save!

    twilio_message = twilio_client.account.messages.create({
      from: @outbound_message.from_phone,
      to: @outbound_message.to_phone,
      body: @outbound_message.body,
      status_callback: message_delivery_status_url(organization_token: current_organization.token,  protocol: 'https'),
    })
    @outbound_message.update_attributes!({
      twilio_message_id: twilio_message.sid,
    })

    redirect_to_back notice: "Message sent!"
  end

private

  def outbound_message_params
    params.require(:outbound_message).permit(:to_phone, :body)
  end
end
