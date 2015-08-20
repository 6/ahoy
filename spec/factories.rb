FactoryGirl.define do
  factory :customer do
    association :organization
    sequence(:phone) { |n| "+184712345#{n}" }
  end

  trait :message do
    association :organization
    body "Hello world!"
    from_phone "+16471234567"
    to_phone "+17471234567"
  end

  factory :inbound_message do
    message
    sequence(:twilio_message_id) { |n| "message-id-#{n}" }
    twilio_data { {some: "data"} }
  end

  factory :outbound_message do
    message
    association :sender_user, factory: :user
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
    sequence(:email) { |n| "john#{n}@example.com" }
    provider "google"
    sequence(:uid) { |n| "google_uid_#{n}" }
    oauth_token "google_oauth_token"
    oauth_expires_at { 1.day.from_now }
  end
end
