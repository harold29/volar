FactoryBot.define do
  factory :price do
    price_total { FFaker::Number.decimal }
    price_grand_total { FFaker::Number.decimal }
    association :price_currency, factory: :currency
    association :billing_currency, factory: :currency
    base_fare { FFaker::Number.decimal }
    refundable_taxes { FFaker::Number.decimal }

    after(:create) do |price|
      create_list(:additional_service, 3, price:)
    end
  end
end
