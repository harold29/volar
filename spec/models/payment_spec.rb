require 'rails_helper'

RSpec.describe Payment, type: :model do
  it 'is valid with valid attributes' do
    expect(build(:payment)).to be_valid
  end

  it 'is not valid without a payment_method' do
    payment = build(:payment, payment_method: nil)
    expect(payment).to_not be_valid
  end

  it 'is not valid without a payment_status' do
    payment = build(:payment, payment_status: nil)
    expect(payment).to_not be_valid
  end

  it 'is not valid without a payment_amount' do
    payment = build(:payment, payment_amount: nil)
    expect(payment).to_not be_valid
  end

  it 'is not valid without a payment_currency' do
    payment = build(:payment, payment_currency: nil)
    expect(payment).to_not be_valid
  end

  it 'is not valid without a payment_datetime' do
    payment = build(:payment, payment_datetime: nil)
    expect(payment).to_not be_valid
  end

  it 'is not valid without a refunded_amount' do
    payment = build(:payment, refunded_amount: nil)
    expect(payment).to_not be_valid
  end

  it 'is not valid without a refunded_currency' do
    payment = build(:payment, refunded_currency: nil)
    expect(payment).to_not be_valid
  end

  it 'is not valid without a booking' do
    payment = build(:payment, booking: nil)
    expect(payment).to_not be_valid
  end

  it 'is not valid without a flight_order' do
    payment = build(:payment, flight_order: nil)
    expect(payment).to_not be_valid
  end

  it 'is not valid without a user' do
    payment = build(:payment, user: nil)
    expect(payment).to_not be_valid
  end

  it 'is not valid with a payment_method longer than 255 characters' do
    payment = build(:payment, payment_method: 'a' * 256)
    expect(payment).to_not be_valid
  end

  it 'is not valid with a refunded_reason longer than 255 characters' do
    payment = build(:payment, refunded_reason: 'a' * 256)
    expect(payment).to_not be_valid
  end

  it 'is not valid with a payment_status not a number' do
    payment = build(:payment, payment_status: 'a')
    expect(payment).to_not be_valid
  end

  it 'is not valid with a payment_amount not a number' do
    payment = build(:payment, payment_amount: 'a')
    expect(payment).to_not be_valid
  end

  it 'is not valid with a refunded_amount not a number' do
    payment = build(:payment, refunded_amount: 'a')
    expect(payment).to_not be_valid
  end

  it 'is not valid with a payment_datetime not a datetime' do
    payment = build(:payment, payment_datetime: 'a')
    expect(payment).to_not be_valid
  end

  # it 'is not valid with a confirmed_at not a datetime' do
  #   payment = build(:payment, confirmed_at: 'a')
  #   expect(payment).to_not be_valid
  # end

  # it 'is not valid with a refunded_at not a datetime' do
  #   payment = build(:payment, refunded_at: 'a')
  #   expect(payment).to_not be_valid
  # end
end
