FactoryBot.define do
  factory :carrier do
    name { FFaker::Company.name }
    logo { FFaker::Image.url }
    code { FFaker::Lorem.word }
  end
end
