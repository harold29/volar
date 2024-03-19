FactoryBot.define do
  factory :itinerary do
    association :flight_offer
    duration { '1H35M' }

    after(:create) do |itinerary|
      create_list(:segment, 3, itinerary:)
    end
  end
end
