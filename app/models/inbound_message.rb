class InboundMessage < Message
  validates :twilio_message_id, presence: true
  validates :twilio_data, presence: true

  belongs_to :customer, inverse_of: :inbound_messages
  belongs_to :organization, inverse_of: :inbound_messages

  def delivered?
    true
  end
end
