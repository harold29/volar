FactoryBot.define do
  factory :additional_service do
    association :flight_offer
    service_type { FFaker::Lorem.word }
    service_description { FFaker::Lorem.word }
    service_amount { FFaker::Number.decimal }
  end
end
