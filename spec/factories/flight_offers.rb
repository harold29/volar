FactoryBot.define do
  factory :flight_offer do
    internal_id { 'MyString' }
    source { 'MyString' }
    instant_ticketing_required { false }
    non_homogeneous { false }
    one_way { false }
    last_ticketing_date { '2024-02-29' }
    last_ticketing_datetime { '2024-02-29T00:00:00' }
    number_of_bookable_seats { 1 }
    price_total { '9.99' }
    payment_card_required { false }
    confirmed { false }
    validating_airline_codes { ['MyString'] }
    pricing_options_fare_type { ['PUBLISHED'] }
    pricing_options_included_checked_bags_only { false }
    pricing_options_refundable_fare { false }
    pricing_options_no_restriction_fare { false }
    pricing_options_no_penalty_fare { false }
    association :currency
    association :flight_search

    after(:build) do |flight_offer|
      create(:price, flight_offer:)
      create_list(:traveler_pricing, 3, flight_offer:)
    end

    after(:create) do |flight_offer|
      create_list(:itinerary, 3, flight_offer:)
    end
  end
end
