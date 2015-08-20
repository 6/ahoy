class MessageDeliveryStatusesController < ApplicationController
  include TwilioMixin

  # before_filter :validate_inbound_twilio_request
  # We need to receive webhooks from Twilio that won't specify the CSRF token.
  skip_before_filter :verify_authenticity_token

  def create
    organization = Organization.find_by_token!(params[:organization_token])
    sms = organization.outbound_messages.find_by_twilio_message_id!(params["MessageSid"])
    sms.update!({
      # e.g. "sent_at", "failed_at"
      "#{params["MessageStatus"]}_at" => Time.now,
    })

    render_empty_twiml
  end
end
