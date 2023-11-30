# frozen_string_literal: true

FactoryBot.define do
  factory :county do
    state
    fips_code { '001' }
    name { 'Los Angeles' }
    fips_class { 'H1' }
    # Add any other attributes you need for your tests
  end
end
