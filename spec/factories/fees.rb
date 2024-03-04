FactoryBot.define do
  factory :fee do
    association :flight_offer
    fee_type { FFaker::Lorem.word }
    fee_description { FFaker::Lorem.word }
    fee_amount { FFaker::Number.decimal }
  end
end
