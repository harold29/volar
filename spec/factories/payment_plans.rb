FactoryBot.define do
  factory :payment_plan do
    name { FFaker::Lorem.word }
    payment_type { FFaker::Lorem.word }
    description { FFaker::Lorem.sentence }
    payment_terms { "D>15;D<30" }
    payment_terms_description { FFaker::Lorem.sentence }
    payment_terms_conditions { FFaker::Lorem.sentence }
    payment_terms_conditions_url { FFaker::Internet.http_url }
    payment_terms_conditions_file { FFaker::Filesystem.file_name }
    payment_terms_conditions_file_url { FFaker::Internet.http_url }
  end
end
