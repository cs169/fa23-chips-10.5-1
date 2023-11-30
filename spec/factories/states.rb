# frozen_string_literal: true

FactoryBot.define do
  factory :state do
    symbol { 'CA' }
    name { 'California' }
    fips_code { '06' }
    is_territory { false }
    lat_min { 32.5343 }
    lat_max { 42.0095 }
    long_min { -124.4096 }
    long_max { -114.1312 }
    # Add any other attributes you need for your tests
  end
end
