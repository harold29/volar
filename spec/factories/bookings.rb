FactoryBot.define do
  factory :booking do
    booking_datetime { FFaker::Time.datetime }
    booking_status { 1 }
    booking_amount { FFaker::Number.decimal }
    association :booking_currency, factory: :currency
    booking_confirmed { false }
    booking_confirmation_datetime { FFaker::Time.datetime }
    booking_confirmation_number { FFaker::String.from_regexp(/\A\w+\z/) }
    payment_type { FFaker::String.from_regexp(/\A\w+\z/) }
    association :payment_plan
    total_installments { FFaker::Random.rand(1..10) }
    installments_amount { FFaker::Number.decimal }
    payments_completed { FFaker::Random.rand(1..10) }
  end
end
