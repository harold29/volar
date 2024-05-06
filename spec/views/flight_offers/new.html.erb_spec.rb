require 'rails_helper'

RSpec.describe 'flight_offers/new', type: :view do
  let(:currency) { create(:currency) }
  before(:each) do
    assign(:flight_offer, FlightOffer.new(
                            internal_id: 'Internal ID',
                            last_ticketing_date: '2024-03-01',
                            last_ticketing_datetime: '2024-03-01T00:00:00',
                            payment_card_required: true,
                            source: 'MyString',
                            instant_ticketing_required: false,
                            non_homogeneous: false,
                            one_way: false,
                            number_of_bookable_seats: 1,
                            price_total: 9.99,
                            currency:
                          ))
  end

  it 'renders new flight_offer form' do
    render

    assert_select 'form[action=?][method=?]', flight_offers_path, 'post' do
      assert_select 'input[name=?]', 'flight_offer[source]'

      assert_select 'input[name=?]', 'flight_offer[instant_ticketing_required]'

      assert_select 'input[name=?]', 'flight_offer[non_homogeneous]'

      assert_select 'input[name=?]', 'flight_offer[one_way]'

      assert_select 'input[name=?]', 'flight_offer[number_of_bookable_seats]'

      assert_select 'input[name=?]', 'flight_offer[price_total]'

      assert_select 'input[name=?]', 'flight_offer[price_currency]'
    end
  end
end
