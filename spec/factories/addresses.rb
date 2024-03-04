FactoryBot.define do
  factory :address do
    association :profile
    address_line_1 { FFaker::Address.street_address }
    address_line_2 { FFaker::Address.secondary_address }
    city { FFaker::Address.city }
    state { FFaker::AddressAU.state }
    postal_code { FFaker::AddressAU.postcode }
    association :country
    address_type { 0 }
    address_verified { false }
  end
end
