FactoryBot.define do
  factory :price do
    association :flight_offer
    price_total { FFaker::Number.decimal }
    price_grand_total { FFaker::Number.decimal }
    association :price_currency, factory: :currency
    association :billing_currency, factory: :currency
    base_fare { FFaker::Number.decimal }
    refundable_taxes { FFaker::Number.decimal }
  end
end
