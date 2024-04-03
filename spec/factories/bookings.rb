FactoryBot.define do
  factory :booking do
    booking_datetime { FFaker::Time.datetime }
    booking_status { 1 }
    booking_amount_due { FFaker::Number.decimal }
    association :booking_currency, factory: :currency
    booking_confirmed { false }
    booking_confirmation_datetime { FFaker::Time.datetime }
    booking_confirmation_number { FFaker::String.from_regexp(/\A\w+\z/) }
    payment_type { FFaker::String.from_regexp(/\A\w+\z/) }
    association :payment_plan
    total_installments { FFaker::Random.rand(1..10) }
    installments_amounts { [FFaker::Number.decimal] }
    installments_paid { FFaker::Random.rand(1..10) }
    installments_number { FFaker::Random.rand(1..10) }
  end
end
