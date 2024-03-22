require 'rails_helper'

RSpec.describe 'flight_searches/index', type: :view do
  let(:currency) { create(:currency) }
  before(:each) do
    assign(:flight_searches, [
             create(:flight_search_with_flight_offers),
             create(:flight_search_with_flight_offers)
           ])
  end

  it 'renders a list of flight_searches' do
    render
    assert_select 'p>strong', text: 'Origin:'.to_s, count: 2
    assert_select 'p>strong', text: 'Destination:'.to_s, count: 2
    assert_select 'p>strong', text: 'Departure date:'.to_s, count: 2
    assert_select 'p>strong', text: 'Return date:'.to_s, count: 2
    assert_select 'p>strong', text: 'Adults:'.to_s, count: 2
    assert_select 'p>strong', text: 'Children:'.to_s, count: 2
    assert_select 'p>strong', text: 'Travel class:'.to_s, count: 2
    assert_select 'p>strong', text: 'Max Price:'.to_s, count: 2
    # assert_select "p>strong", text: false.to_s, count: 2
    # assert_select "p>strong", text: false.to_s, count: 2
    # assert_select "p>strong", text: false.to_s, count: 2
    # assert_select "p>strong", text: 2.to_s, count: 2
    # assert_select "p>strong", text: "9.99".to_s, count: 2
    # assert_select "p>strong", text: "Price Currency".to_s, count: 2
  end
end
