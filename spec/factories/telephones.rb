FactoryBot.define do
  factory :telephone do
    association :user
    area_code { FFaker::PhoneNumber.area_code }
    phone_number { FFaker::PhoneNumber.phone_number }
    phone_type { 1 }
    phone_verified { false }
  end
end
