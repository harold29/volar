require 'rails_helper'

RSpec.describe "flight_offers/edit", type: :view do
  let(:currency) { create(:currency) }
  before(:each) do
    @flight_offer = assign(:flight_offer, FlightOffer.create!(
      internal_id: "Internal ID",
      last_ticketing_date: "2024-03-01",
      payment_card_required: true,
      source: "MyString",
      instant_ticketing_required: false,
      non_homogeneous: false,
      one_way: false,
      number_of_bookable_seats: 1,
      price_total: 9.99,
      currency: currency
    ))
  end

  it "renders the edit flight_offer form" do
    render

    assert_select "form[action=?][method=?]", flight_offer_path(@flight_offer), "post" do

      assert_select "input[name=?]", "flight_offer[source]"

      assert_select "input[name=?]", "flight_offer[instant_ticketing_required]"

      assert_select "input[name=?]", "flight_offer[non_homogeneous]"

      assert_select "input[name=?]", "flight_offer[one_way]"

      assert_select "input[name=?]", "flight_offer[number_of_bookable_seats]"

      assert_select "input[name=?]", "flight_offer[price_total]"

      assert_select "input[name=?]", "flight_offer[price_currency]"
    end
  end
end
