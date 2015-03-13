class InboundMessagesController < ApplicationController
  include TwilioMixin

  # before_filter :validate_inbound_twilio_request
  # We need to receive webhooks from Twilio that won't specify the CSRF token.
  skip_before_filter :verify_authenticity_token

  def create
    organization = Organization.find_by_token(params[:organization_token])
    organization.inbound_messages.create!({
      from_phone: params["From"],
      to_phone: params["To"],
      body: params["Body"],
      twilio_message_id: params["MessageSid"],
      twilio_data: params,
    })

    render_empty_twiml
  end
end
