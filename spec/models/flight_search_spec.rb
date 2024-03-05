require 'rails_helper'

RSpec.describe FlightSearch, type: :model do
  it 'is valid with valid attributes' do
    expect(build(:flight_search)).to be_valid
  end

  it 'is not valid without a user' do
    flight_search = build(:flight_search, user: nil)
    expect(flight_search).to_not be_valid
  end

  it 'is not valid without an origin' do
    flight_search = build(:flight_search, origin: nil)
    expect(flight_search).to_not be_valid
  end

  it 'is not valid without a destination' do
    flight_search = build(:flight_search, destination: nil)
    expect(flight_search).to_not be_valid
  end

  it 'is not valid without a departure_date' do
    flight_search = build(:flight_search, departure_date: nil)
    expect(flight_search).to_not be_valid
  end

  it 'is not valid without adults' do
    flight_search = build(:flight_search, adults: nil)
    expect(flight_search).to_not be_valid
  end

  it 'is not valid without a travel_class' do
    flight_search = build(:flight_search, travel_class: nil)
    expect(flight_search).to_not be_valid
  end

  it 'is not valid without a one_way' do
    flight_search = build(:flight_search, one_way: nil)
    expect(flight_search).to_not be_valid
  end

  it 'is not valid without a max_price' do
    flight_search = build(:flight_search, max_price: nil)
    expect(flight_search).to_not be_valid
  end

  it 'is not valid without a max_price_currency' do
    flight_search = build(:flight_search, max_price_currency: nil)
    expect(flight_search).to_not be_valid
  end

  it 'is not valid without a max_stops' do
    flight_search = build(:flight_search, max_stops: nil)
    expect(flight_search).to_not be_valid
  end

  it 'is not valid without a max_duration_unit' do
    flight_search = build(:flight_search, max_duration_unit: nil)
    expect(flight_search).to_not be_valid
  end

  it 'is not valid without a price_total' do
    flight_search = build(:flight_search, price_total: nil)
    expect(flight_search).to_not be_valid
  end

  it 'is not valid without a price_average' do
    flight_search = build(:flight_search, price_average: nil)
    expect(flight_search).to_not be_valid
  end

  # it 'is not valid with a max_price longer than 255 characters' do
  #   flight_search = build(:flight_search, max_price: 'a' * 256)
  #   expect(flight_search).to_not be_valid
  # end

  # it 'is not valid with a max_duration longer than 255 characters' do
  #   flight_search = build(:flight_search, max_duration: 'a' * 256)
  #   expect(flight_search).to_not be_valid
  # end

  # it 'is not valid with a max_duration_unit longer than 255 characters' do
  #   flight_search = build(:flight_search, max_duration_unit: 'a' * 256)
  #   expect(flight_search).to_not be_valid
  # end
end
