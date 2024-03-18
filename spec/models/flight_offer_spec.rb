require 'rails_helper'

RSpec.describe FlightOffer, type: :model do
  let(:currency) { create(:currency) }

  it 'is valid with all parameters' do
    flight_offer = FlightOffer.new(
      internal_id: 'Internal ID',
      source: 'Source',
      instant_ticketing_required: true,
      non_homogeneous: true,
      one_way: true,
      last_ticketing_date: '2024-03-01',
      last_ticketing_datetime: '2024-03-01T00:00:00',
      number_of_bookable_seats: 1,
      price_total: 1.5,
      payment_card_required: true,
      currency:
    )

    expect(flight_offer).to be_valid
  end

  it 'is invalid without an internal id' do
    flight_offer = FlightOffer.new(internal_id: nil)
    flight_offer.valid?
    expect(flight_offer.errors[:internal_id]).to include("can't be blank")
  end

  it 'is invalid without a source' do
    flight_offer = FlightOffer.new(source: nil)
    flight_offer.valid?
    expect(flight_offer.errors[:source]).to include("can't be blank")
  end

  it 'is invalid without a last ticketing date' do
    flight_offer = FlightOffer.new(last_ticketing_date: nil)
    flight_offer.valid?
    expect(flight_offer.errors[:last_ticketing_date]).to include("can't be blank")
  end

  it 'is invalid without a last ticketing datetime' do
    flight_offer = FlightOffer.new(last_ticketing_datetime: nil)
    flight_offer.valid?
    expect(flight_offer.errors[:last_ticketing_datetime]).to include("can't be blank")
  end

  it 'is invalid without a number of bookable seats' do
    flight_offer = FlightOffer.new(number_of_bookable_seats: nil)
    flight_offer.valid?
    expect(flight_offer.errors[:number_of_bookable_seats]).to include("can't be blank")
  end

  it 'is invalid without a price total' do
    flight_offer = FlightOffer.new(price_total: nil)
    flight_offer.valid?
    expect(flight_offer.errors[:price_total]).to include("can't be blank")
  end

  it 'is invalid without a currency' do
    flight_offer = FlightOffer.new(currency: nil)
    flight_offer.valid?
    expect(flight_offer.errors[:currency]).to include('must exist')
  end
end
