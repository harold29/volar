FactoryBot.define do
  factory :flight_search do
    association :user
    origin { FFaker::Address.city }
    destination { FFaker::Address.city }
    departure_date { FFaker::Time.date }
    return_date { FFaker::Time.date }
    one_way { FFaker::Boolean.maybe }
    adults { FFaker::Random.rand(1..10) }
    children { FFaker::Random.rand(1..10) }
    infants { FFaker::Random.rand(1..10) }
    travel_class { FFaker::Lorem.word }
    max_price { FFaker::Number.decimal }
    association :max_price_currency, factory: :currency
    max_stops { FFaker::Random.rand(1..10) }
    max_duration { '1H' }
    max_duration_unit { 'hours' }
    price_total { FFaker::Number.decimal }
    price_average { FFaker::Number.decimal }
    association :currency
    nonstop { FFaker::Boolean.maybe }
  end
end
