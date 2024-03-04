FactoryBot.define do
  factory :tax do
    association :flight_offer
    tax_code { FFaker::Lorem.word }
    tax_description { FFaker::Lorem.word }
    tax_amount { FFaker::Number.decimal }
  end
end
