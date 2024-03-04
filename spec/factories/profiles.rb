# frozen_string_literal: true

FactoryBot.define do
  factory :profile do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    phone_number_1 { FFaker::PhoneNumberBR.mobile_phone_number }
    phone_number_2 { FFaker::PhoneNumberBR.mobile_phone_number }
    gender { FFaker::Gender.random }
    birthdate { DateTime.parse('2022-01-31') }
    association :user
  end
end
