FactoryGirl.define do
  factory :customer do
    association :organization
    phone "+18471234567"
  end

  factory :message do
    association :organization
    type "InboundMessage"
    body "Hello world!"
    from_phone "+16471234567"
    to_phone "+17471234567"
  end

  factory :organization do
    sequence(:name) { |n| "Company #{n}" }
    sequence(:email_domain) { |n| "company#{n}.com" }
    phone "+16471234567"
    sequence(:token) { |n| "random#{n}" }
    twilio_account_sid "twilio_account_sid"
    twilio_auth_token "twilio_auth_token"
  end

  factory :user do
    given_name "John"
    surname "Smith"
    sequence(:email) { "john@example.com" }
    provider "google"
    uid "google_uid"
    oauth_token "google_oauth_token"
    oauth_expires_at { 1.day.from_now }
  end
end
