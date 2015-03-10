class Organization < ActiveRecord::Base
  before_validation :generate_token

  validates :name, presence: true
  validates :twilio_account_sid, presence: true
  validates :twilio_auth_token, presence: true
  validates :token, presence: true, uniqueness: true

  has_many :user_organizations, dependent: :destroy
  has_many :users, through: :user_organizations

private

  def generate_token
    self.token ||= SecureRandom.uuid
  end
end
