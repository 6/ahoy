class Message < ActiveRecord::Base
  belongs_to :customer, inverse_of: :messages, touch: true
  belongs_to :organization, inverse_of: :messages

  validates :body, presence: true, length: {maximum: 160}
  validates :customer, presence: true
  validates :customer_phone, presence: true
  validates :organization, presence: true

  before_validation :set_customer, if: :customer_phone
  before_validation :set_customer_phone, if: :customer

  def set_customer
    self.customer ||= organization.customers.find_or_create_by!(phone: customer_phone)
  end

  def set_customer_phone
    if inbound?
      self.from_phone ||= customer.phone
    else
      self.to_phone ||= customer.phone
    end
  end

  def customer_phone
    if inbound?
      from_phone
    else
      to_phone
    end
  end

  def inbound?
    type == "InboundMessage"
  end

  def outbound?
    type == "OutboundMessage"
  end
end
