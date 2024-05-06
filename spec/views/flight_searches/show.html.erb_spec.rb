require 'rails_helper'

RSpec.describe 'flight_searches/show', type: :view do
  let(:flight_search) do
    create(:flight_search,
           origin: 'Origin',
           destination: 'Destination',
           departure_date: '2024-03-01',
           return_date: '2024-03-01',
           one_way: false,
           adults: 3,
           children: 4,
           infants: 5,
           travel_class: 'Travel Class',
           nonstop: false)
  end
  let(:flight_offers) { create_list(:flight_offer, 3, flight_search:) }

  before(:each) do
    flight_search.flight_offers = flight_offers
    flight_search.save

    @flight_search = assign(:flight_search, flight_search)
  end

  it 'renders attributes in <p>' do
    render

    expect(rendered).to match(/Origin/)
    expect(rendered).to match(/Destination/)
    expect(rendered).to match(/2024-03-01/)
    expect(rendered).to match(/2024-03-01/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/Travel Class/)
    # expect(rendered).to match(/false/)
  end

  it 'renders a list of flight_offers' do
    render

    assert_select 'div#flight_offers div[id^=flight_offer_] p', text: /MyString/, count: 3
    # assert_select 'div#flight_offers div[id^=flight_offer_] p', text: /false/, count: 3
    assert_select 'div#flight_offers div[id^=flight_offer_] p', text: /#{flight_search.flight_offers.first.price_total}/, count: 3
  end
end
