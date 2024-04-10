FactoryBot.define do
  factory :price do
    price_total { FFaker::Number.decimal }
    price_grand_total { FFaker::Number.decimal }
    association :price_currency, factory: :currency
    association :billing_currency, factory: :currency
    base_fare { FFaker::Number.decimal }
    refundable_taxes { FFaker::Number.decimal }
    association :flight_offer

    after(:create) do |price|
      create_list(:additional_service, 3, price:)
      create_list(:fee, 3, price:)
    end
  end

  factory :price_with_traveler_pricing do
    price_total { FFaker::Number.decimal }
    price_grand_total { FFaker::Number.decimal }
    association :price_currency, factory: :currency
    association :billing_currency, factory: :currency
    base_fare { FFaker::Number.decimal }
    refundable_taxes { FFaker::Number.decimal }
    association :traveler_pricing

    after(:create) do |price|
      create_list(:additional_service, 3, price:)
      create_list(:fee, 3, price:)
    end
  end
end
