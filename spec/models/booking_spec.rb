require 'rails_helper'

RSpec.describe Booking, type: :model do
  it 'is valid with valid attributes' do
    expect(build(:booking)).to be_valid
  end

  it 'is not valid without a booking_datetime' do
    booking = build(:booking, booking_datetime: nil)
    expect(booking).to_not be_valid
  end

  it 'is not valid without a booking_status' do
    booking = build(:booking, booking_status: nil)
    expect(booking).to_not be_valid
  end

  it 'is not valid without a booking_amount' do
    booking = build(:booking, booking_amount: nil)
    expect(booking).to_not be_valid
  end

  it 'is not valid without a booking_currency' do
    booking = build(:booking, booking_currency: nil)
    expect(booking).to_not be_valid
  end

  it 'is not valid without a booking_confirmed' do
    booking = build(:booking, booking_confirmed: nil)
    expect(booking).to_not be_valid
  end

  it 'is not valid without a booking_confirmation_datetime' do
    booking = build(:booking, booking_confirmation_datetime: nil)
    expect(booking).to_not be_valid
  end

  it 'is not valid without a booking_confirmation_number' do
    booking = build(:booking, booking_confirmation_number: nil)
    expect(booking).to_not be_valid
  end

  it 'is not valid without a payment_type' do
    booking = build(:booking, payment_type: nil)
    expect(booking).to_not be_valid
  end

  it 'is not valid without a payment_plan' do
    booking = build(:booking, payment_plan: nil)
    expect(booking).to_not be_valid
  end

  it 'is not valid without a total_installments' do
    booking = build(:booking, total_installments: nil)
    expect(booking).to_not be_valid
  end

  it 'is not valid without a installments_amount' do
    booking = build(:booking, installments_amount: nil)
    expect(booking).to_not be_valid
  end

  it 'is not valid without a payments_completed' do
    booking = build(:booking, payments_completed: nil)
    expect(booking).to_not be_valid
  end
end
