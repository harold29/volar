require 'rails_helper'

RSpec.describe Price, type: :model do
  let(:currency) { create(:currency) }
  let(:flight_offer) { create(:flight_offer) }

  it 'is valid with all parameters' do
    price = Price.new(
      price_total: 1.5,
      price_grand_total: 1.5,
      base_fare: 1.5,
      refundable_taxes: 1.5,
      billing_currency: currency,
      price_currency: currency,
      flight_offer:
    )

    expect(price).to be_valid
  end

  it 'is invalid without a price_total' do
    price = Price.new(price_total: nil)
    price.valid?
    expect(price.errors[:price_total]).to include("can't be blank")
  end

  it 'is invalid without a price_grand_total' do
    price = Price.new(price_grand_total: nil)
    price.valid?
    expect(price.errors[:price_grand_total]).to include("can't be blank")
  end

  it 'is invalid without a base_fare' do
    price = Price.new(base_fare: nil)
    price.valid?
    expect(price.errors[:base_fare]).to include("can't be blank")
  end

  it 'is invalid without a billing_currency' do
    price = Price.new(billing_currency: nil)
    price.valid?
    expect(price.errors[:billing_currency]).to include('must exist')
  end

  it 'is invalid without a price_currency' do
    price = Price.new(price_currency: nil)
    price.valid?
    expect(price.errors[:price_currency]).to include('must exist')
  end

  it 'is valid without a flight_offer' do
    price = build(:price, flight_offer: nil)
    expect(price.valid?).to be true
  end

  it 'is invalid with a non-numeric price_total' do
    price = Price.new(price_total: 'abc')
    price.valid?
    expect(price.errors[:price_total]).to include('is not a number')
  end

  it 'is invalid with a non-numeric price_grand_total' do
    price = Price.new(price_grand_total: 'abc')
    price.valid?
    expect(price.errors[:price_grand_total]).to include('is not a number')
  end

  it 'is invalid with a non-numeric base_fare' do
    price = Price.new(base_fare: 'abc')
    price.valid?
    expect(price.errors[:base_fare]).to include('is not a number')
  end

  it 'is invalid with a non-numeric refundable_taxes' do
    price = Price.new(refundable_taxes: 'abc')
    price.valid?
    expect(price.errors[:refundable_taxes]).to include('is not a number')
  end

  it 'is invalid with a non-numeric price_total' do
    price = Price.new(price_total: 'abc')
    price.valid?
    expect(price.errors[:price_total]).to include('is not a number')
  end
end
