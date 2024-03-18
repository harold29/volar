FactoryBot.define do
  factory :payment_plan do
    departure_at { (Time.now + 15.days).to_date }
    return_at { (Time.now + 25.days).to_date }
    installments_number { 1 }
    installment_amounts { [FFaker::Number.decimal] }
    last_ticketing_datetime { FFaker::Time.datetime }
    active { false }
    selected { false }
    association :flight_offer
    association :installments_currency, factory: :currency
    association :payment_term
  end
end
