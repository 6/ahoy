class Organization < ActiveRecord::Base
  validates :name, presence: true
  validates :twilio_account_sid, presence: true
  validates :twilio_auth_token, presence: true

  has_many :user_organizations, dependent: :destroy
  has_many :users, through: :user_organizations
end
