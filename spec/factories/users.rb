# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    uid { '123456' }
    provider { 'google_oauth2' }
    first_name { 'John' }
    last_name { 'Doe' }
    email { 'john.doe@example.com' }
    # Add any other attributes you need for your tests
  end
end
