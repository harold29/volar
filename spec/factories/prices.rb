FactoryBot.define do
  factory :price do
    association :flight_offer
    price_total { FFaker::Number.decimal(2) }
    price_grand_total { FFaker::Number.decimal(2) }
    association :price_currency, factory: :currency
    association :billing_currency, factory: :currency
    base_fare { FFaker::Number.decimal(2) }
    refundable_taxes { FFaker::Number.decimal(2) }
  end
end
