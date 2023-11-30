# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    county
    name { 'Sample Event' }
    description { 'This is a sample event.' }
    start_time { Time.zone.now + 1.day } # Start time is after today
    end_time { Time.zone.now + 2.days } # End time is after start time
    # Add any other attributes you need for your tests
  end
end
