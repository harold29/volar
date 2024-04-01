require 'rails_helper'

RSpec.describe FlightOrder, type: :model do
  it 'is valid with valid attributes' do
    expect(build(:flight_order)).to be_valid
  end

  it 'is not valid without a order_datetime' do
    flight_order = build(:flight_order, order_datetime: nil)
    expect(flight_order).to_not be_valid
  end

  it 'is not valid without a order_status' do
    flight_order = build(:flight_order, order_status: nil)
    expect(flight_order).to_not be_valid
  end

  it 'is not valid without a total_price' do
    flight_order = build(:flight_order, total_price: nil)
    expect(flight_order).to_not be_valid
  end

  it 'is not valid without a order_id' do
    flight_order = build(:flight_order, order_id: nil)
    expect(flight_order).to_not be_valid
  end

  it 'is not valid without a booking' do
    flight_order = build(:flight_order, booking: nil)
    expect(flight_order).to_not be_valid
  end

  # it 'is not valid without a payment' do
  #   flight_order = build(:flight_order, payment: nil)
  #   expect(flight_order).to_not be_valid
  # end

  it 'is not valid without a total_price_currency' do
    flight_order = build(:flight_order, total_price_currency: nil)
    expect(flight_order).to_not be_valid
  end

  it 'is not valid with a order_id longer than 255 characters' do
    flight_order = build(:flight_order, order_id: 'a' * 256)
    expect(flight_order).to_not be_valid
  end
end
