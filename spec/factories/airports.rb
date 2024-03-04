FactoryBot.define do
  factory :airport do
    name { FFaker::Address.street_name }
    city { FFaker::Address.city }
    iata_code { Faker::Travel::Airport.iata(size: 'large', region: 'united_states') }
    icao_code { "MyString" }
    time_zone { FFaker::Address.time_zone }
    association :country
  end
end
