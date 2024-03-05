FactoryBot.define do
  factory :document do
    document_type { 0 }
    document_number { FFaker::IdentificationESCO.drivers_license }
    expiration_date { FFaker::IdentificationESCO.expedition_date }
    association :issuance_country, factory: :country
    association :nationality, factory: :country
  end
end
