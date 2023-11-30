# frozen_string_literal: true

FactoryBot.define do
  factory :news_item do
    representative
    title { 'Sample News Item' }
    link { 'http://www.newsbtc.com/analysis/eth/ethereum-price-rally-jeopardy-2075/' }
    # Add any other attributes you need for your tests
  end
end
