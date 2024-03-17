FactoryBot.define do
  factory :payment_plan do
    departure_at { FFaker::Time.date }
    return_at { FFaker::Time.date }
    installments_number { 12 }
    installment_amounts { [FFaker::Number.decimal] }
    active { false }
    selected { false }
    association :flight_offer
    association :installments_currency, factory: :currency
    association :payment_term
  end
end
