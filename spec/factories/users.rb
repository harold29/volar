FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    password { FFaker::Internet.password }
    confirmed_at { Time.now }
  end

  factory :admin, class: "User" do
    email { FFaker::Internet.email }
    password { FFaker::Internet.password }
    role { 2 }
  end
end
