FactoryBot.define do
  factory :traveler_pricing do
    association :flight_offer
    fare_option { FFaker::Lorem.word }
    traveler_type { FFaker::Lorem.word }
    price_total { FFaker::Number.decimal }
    association :price_currency, factory: :currency
    traveler_internal_id { rand(1..10).to_s }
    price_base { FFaker::Number.decimal }

    after(:create) do |traveler_pricing|
      create_list(:fare_details_by_segment, 3, traveler_pricing:)
    end
  end
end
