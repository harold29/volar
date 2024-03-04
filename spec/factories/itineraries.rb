FactoryBot.define do
  factory :itinerary do
    association :flight_offer
    duration { '1H35M' }
  end
end
