FactoryBot.define do
  factory :flight_order do
    association :booking
    # association :payment
    order_id { FFaker::String.from_regexp(/\A\w+\z/) }
    order_datetime { FFaker::Time.datetime }
    order_status { FFaker::Random.rand(1..10) }
    total_price { FFaker::Number.decimal }
    association :total_price_currency, factory: :currency
  end
end
