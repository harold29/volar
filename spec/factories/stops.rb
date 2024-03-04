FactoryBot.define do
  factory :stop do
    association :segment
    association :airport
    duration { '1H35M06S' }
    arrival_at { FFaker::Time.datetime }
    departure_at { FFaker::Time.datetime }
  end
end
