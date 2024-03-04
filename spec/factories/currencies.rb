FactoryBot.define do
  factory :currency do
    name { FFaker::Currency.name }
    code { FFaker::Currency.code }
    symbol { FFaker::Currency.symbol }
    association :country
  end
end
