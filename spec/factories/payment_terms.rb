FactoryBot.define do
  factory :payment_term do
    name { FFaker::Lorem.word }
    description { FFaker::Lorem.sentence }
    payment_type { 1 }
    payment_terms { FFaker::Lorem.word }
    payment_terms_description { FFaker::Lorem.sentence }
    payment_terms_conditions { FFaker::Lorem.word }
    payment_terms_conditions_url { FFaker::Internet.http_url }
    payment_terms_file { FFaker::Filesystem.file_name }
    payment_terms_file_url { FFaker::Internet.http_url }
    days_max_number { 30 }
    days_min_number { 15 }
    payment_period_in_days { 1 }
    interest_rate { FFaker::Number.decimal }
    penalty_rate { FFaker::Number.decimal }
    installments_max_number { 12 }
    installments_min_number { 1 }
    installments { false }
    active { false }
    deleted { false }
  end
end
