require 'rails_helper'

RSpec.describe 'flight_offers/show', type: :view do
  let(:currency) { create(:currency, name: 'testcurrency') }
  before(:each) do
    @flight_offer = assign(:flight_offer, FlightOffer.create!(
                                            last_ticketing_date: '2024-03-01',
                                            last_ticketing_datetime: '2024-03-01T00:00:00',
                                            internal_id: 'Internal ID',
                                            source: 'Source',
                                            instant_ticketing_required: false,
                                            non_homogeneous: false,
                                            one_way: false,
                                            number_of_bookable_seats: 2,
                                            price_total: '9.99',
                                            currency:
                                          ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Source/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/testcurrency/)
  end
end
