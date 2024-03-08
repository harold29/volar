FactoryBot.define do
  factory :traveler_pricing do
    association :flight_offer
    association :traveler
    fare_option { FFaker::Lorem.word }
    traveler_type { FFaker::Lorem.word }
    price_total { FFaker::Number.decimal }
    association :price_currency, factory: :currency
    flight_offer_internal_id { rand(1..10).to_s }
  end
end
