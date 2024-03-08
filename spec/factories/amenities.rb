FactoryBot.define do
  factory :amenity do
    association :fare_details_by_segment
    description { FFaker::Lorem.sentence }
    is_chargeable { false }
    amenity_type { FFaker::Lorem.word }
    amenity_provider_name { FFaker::Lorem.word }
  end
end
