class Customer < ActiveRecord::Base
  belongs_to :organization, inverse_of: :customers
  has_many :messages, inverse_of: :customer
  has_many :inbound_messages, inverse_of: :customer
  has_many :outbound_messages, inverse_of: :customer

  validates :phone, presence: true, uniqueness: true
end
