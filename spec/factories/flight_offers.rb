FactoryBot.define do
  factory :flight_offer do
    source { "MyString" }
    instant_ticketing_required { false }
    non_homogeneous { false }
    one_way { false }
    last_ticketing_date { "2024-02-29" }
    number_of_bookable_seats { 1 }
    price_total { "9.99" }
    association :currency
  end
end
