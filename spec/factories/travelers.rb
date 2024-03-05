FactoryBot.define do
  factory :traveler do
    association :user
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    email { FFaker::Internet.email }
    traveler_type { 1 }
    birthdate { FFaker::Time.date }
    association :document
    association :telephone
  end
end
