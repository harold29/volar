FactoryBot.define do
  factory :payment do
    association :flight_order
    association :user
    payment_method { FFaker::Lorem.word }
    payment_status { FFaker::Random.rand(0..3) }
    payment_amount { FFaker::Number.decimal }
    association :payment_currency, factory: :currency
    payment_datetime { FFaker::Time.datetime }
    confirmed_at { FFaker::Time.datetime }
    approved { false }
    declined { false }
    refunded { false }
    refunded_at { FFaker::Time.datetime }
    refunded_amount { FFaker::Number.decimal }
    association :refunded_currency, factory: :currency
    refunded_reason { FFaker::Lorem.sentence }
    association :booking
  end
end
