FactoryBot.define do
  factory :traveler_pricing do
    association :flight_offer
    fare_option { FFaker::Lorem.word }
    traveler_type { FFaker::Lorem.word }
    price_total { FFaker::Number.decimal }
    # association :price_currency, factory: :currency
    # price_currency { association(:currency) }
    price_currency { create(:currency) }
    traveler_internal_id { rand(1..10).to_s }
    price_base { FFaker::Number.decimal }

    # after(:build) do |traveler_pricing|
    #   create(:currency)
    # end

    after(:create) do |traveler_pricing|
      create_list(:fare_details_by_segment, 3, traveler_pricing:)
      create(:price_with_traveler_pricing, traveler_pricing:)
    end
  end
end
