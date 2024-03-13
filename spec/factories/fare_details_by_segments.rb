FactoryBot.define do
  factory :fare_details_by_segment do
    association :traveler_pricing
    cabin { FFaker::Lorem.word }
    fare_basis { FFaker::Lorem.word }
    branded_fare { FFaker::Lorem.word }
    branded_fare_label { FFaker::Lorem.word }
    flight_class { FFaker::Lorem.word }
    segment_internal_id { rand(1..10).to_s }
    included_checked_bags { rand(1..5) }
  end
end
