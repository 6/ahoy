class OutboundMessage < Message
  DELIVERY_STATUSES = %w[
    queued_at
    sending_at
    sent_at
    failed_at
    delivered_at
  ]
  store_accessor :delivery_statuses, DELIVERY_STATUSES

  belongs_to :sender, class_name: "User", inverse_of: :outbound_messages
  belongs_to :organization, inverse_of: :outbound_messages

  validates :sender, presence: true
end
