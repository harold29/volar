FactoryBot.define do
  factory :tax do
    association :price
    tax_code { FFaker::Lorem.word }
    tax_description { FFaker::Lorem.word }
    tax_amount { FFaker::Number.decimal }
  end
end
