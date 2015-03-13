module TwilioMixin
  extend ActiveSupport::Concern

  # TwiML is the XML response format that Twilio implements. See docs:
  # https://www.twilio.com/docs/api/twiml
  def render_twiml(twiml_response)
    response.headers["Content-Type"] = "text/xml"
    render text: twiml_response.text
  end

  # Renders an empty TwiML response. Useful for indicating to Twilio that a
  # webhook was successfully received.
  def render_empty_twiml
    render_twiml Twilio::TwiML::Response.new
  end

  def twilio_client
    @twilio_client ||= Twilio::REST::Client.new(current_organization.twilio_account_sid, current_organization.twilio_auth_token)
  end

  # Implemented per instructions here:
  # https://github.com/twilio/twilio-ruby/wiki/RequestValidator
  def validate_inbound_twilio_request
    return true  if Rails.env.development?

    validator = Twilio::Util::RequestValidator.new(current_organization.twilio_auth_token)
    params = request.get? ? env['rack.request.query_hash'] : env['rack.request.form_hash']

    if !validator.validate(request.original_url, params, request.headers['HTTP_X_TWILIO_SIGNATURE'])
      raise "Invalid Twilio request"
    end
  end
end
