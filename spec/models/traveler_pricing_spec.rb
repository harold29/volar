require 'rails_helper'

RSpec.describe TravelerPricing, type: :model do
  it 'is valid with valid attributes' do
    expect(build(:traveler_pricing)).to be_valid
  end

  it 'is invalid without a flight offer' do
    traveler_pricing = build(:traveler_pricing, flight_offer: nil)
    traveler_pricing.valid?
    expect(traveler_pricing.errors[:flight_offer]).to include('must exist')
  end

  it 'is invalid without a traveler' do
    traveler_pricing = build(:traveler_pricing, traveler: nil)
    traveler_pricing.valid?
    expect(traveler_pricing.errors[:traveler]).to include('must exist')
  end

  it 'is invalid without a fare option' do
    traveler_pricing = build(:traveler_pricing, fare_option: nil)
    traveler_pricing.valid?
    expect(traveler_pricing.errors[:fare_option]).to include("can't be blank")
  end

  it 'is invalid without a traveler type' do
    traveler_pricing = build(:traveler_pricing, traveler_type: nil)
    traveler_pricing.valid?
    expect(traveler_pricing.errors[:traveler_type]).to include("can't be blank")
  end

  it 'is invalid without a price total' do
    traveler_pricing = build(:traveler_pricing, price_total: nil)
    traveler_pricing.valid?
    expect(traveler_pricing.errors[:price_total]).to include("can't be blank")
  end

  it 'is invalid without a price currency' do
    traveler_pricing = build(:traveler_pricing, price_currency: nil)
    traveler_pricing.valid?
    expect(traveler_pricing.errors[:price_currency]).to include('must exist')
  end

  it 'is invalid without a flight offer internal id' do
    traveler_pricing = build(:traveler_pricing, flight_offer_internal_id: nil)
    traveler_pricing.valid?
    expect(traveler_pricing.errors[:flight_offer_internal_id]).to include("can't be blank")
  end

  it 'is invalid with a non-numeric price total' do
    traveler_pricing = build(:traveler_pricing, price_total: 'abc')
    traveler_pricing.valid?
    expect(traveler_pricing.errors[:price_total]).to include('is not a number')
  end
end
