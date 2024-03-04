FactoryBot.define do
  factory :country do
    name { FFaker::Address.country }
    code { FFaker::Address.country_code }
    phone_code { FFaker::PhoneNumber.area_code }
    language { FFaker::Locale.language }
    continent { "America" }
    time_zone { FFaker::Address.time_zone }
  end
end
