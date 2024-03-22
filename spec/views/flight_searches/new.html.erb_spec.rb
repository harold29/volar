require 'rails_helper'

RSpec.describe 'flight_searches/new', type: :view do
  let(:flight_search) do
    build(:flight_search,
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
  # let(:flight_offers) { create_list(:flight_offer, 3, flight_search:) }
  before(:each) do
    assign(:flight_search, flight_search)
  end

  it 'renders new flight_search form' do
    render

    assert_select 'form[action=?][method=?]', flight_searches_path, 'post' do
      assert_select 'input[name=?]', 'flight_search[origin]'

      assert_select 'input[name=?]', 'flight_search[destination]'

      assert_select 'input[name=?]', 'flight_search[departure_date]'

      assert_select 'input[name=?]', 'flight_search[return_date]'

      assert_select 'input[name=?]', 'flight_search[one_way]'

      assert_select 'input[name=?]', 'flight_search[adults]'

      assert_select 'input[name=?]', 'flight_search[children]'

      assert_select 'input[name=?]', 'flight_search[infants]'

      assert_select 'input[name=?]', 'flight_search[travel_class]'

      assert_select 'input[name=?]', 'flight_search[nonstop]'
    end
  end
end
