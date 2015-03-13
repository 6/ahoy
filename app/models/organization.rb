class Organization < ActiveRecord::Base
  before_validation :generate_token

  validates :name, presence: true
  validates :twilio_account_sid, presence: true
  validates :twilio_auth_token, presence: true
  validates :token, presence: true, uniqueness: true
  validates :email_domain, presence: true, uniqueness: true

  has_many :users, inverse_of: :organization

  def twilio_client
    @twilio_client ||= Twilio::REST::Client.new(twilio_account_sid, twilio_auth_token)
  end

private

  def generate_token
    self.token ||= SecureRandom.uuid
  end
end
