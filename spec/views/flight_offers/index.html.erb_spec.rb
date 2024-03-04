require 'rails_helper'

RSpec.describe "flight_offers/index", type: :view do
  let(:currency) { create(:currency) }
  before(:each) do
    assign(:flight_offers, [
      FlightOffer.create!(
        internal_id: "Internal ID",
        last_ticketing_date: "2024-03-01",
        payment_card_required: true,
        source: "Source",
        instant_ticketing_required: false,
        non_homogeneous: false,
        one_way: false,
        number_of_bookable_seats: 2,
        price_total: 9.99,
        currency: currency
      ),
      FlightOffer.create!(
        internal_id: "Internal ID",
        last_ticketing_date: "2024-03-01",
        payment_card_required: true,
        source: "Source",
        instant_ticketing_required: false,
        non_homogeneous: false,
        one_way: false,
        number_of_bookable_seats: 2,
        price_total: 9.99,
        currency: currency
      )
    ])
  end

  it "renders a list of flight_offers" do
    render
    assert_select "p>strong", text: "Source:".to_s, count: 2
    assert_select "p>strong", text: "Instant ticketing required:".to_s, count: 2
    assert_select "p>strong", text: "Non homogeneous:".to_s, count: 2
    assert_select "p>strong", text: "One way:".to_s, count: 2
    assert_select "p>strong", text: "Last ticketing date:".to_s, count: 2
    assert_select "p>strong", text: "Number of bookable seats:".to_s, count: 2
    assert_select "p>strong", text: "Price total:".to_s, count: 2
    assert_select "p>strong", text: "Price currency:".to_s, count: 2
    # assert_select "p>strong", text: false.to_s, count: 2
    # assert_select "p>strong", text: false.to_s, count: 2
    # assert_select "p>strong", text: false.to_s, count: 2
    # assert_select "p>strong", text: 2.to_s, count: 2
    # assert_select "p>strong", text: "9.99".to_s, count: 2
    # assert_select "p>strong", text: "Price Currency".to_s, count: 2
  end
end
