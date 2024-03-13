FactoryBot.define do
  factory :segment do
    association :itinerary
    departure_at { FFaker::Time.datetime }
    arrival_at { FFaker::Time.datetime }
    association :carrier
    association :departure_airport, factory: :airport
    association :arrival_airport, factory: :airport
    flight_number { FFaker::Number.number.to_s }
    aircraft_code { FFaker::NatoAlphabet.code }
    duration { '8H4M5S' }
    stops_number { 1 }
    blacklisted_in_eu { false }
    internal_id { rand(1..200).to_s }
  end
end
