require 'rails_helper'

RSpec.describe Booking, type: :model do
  it 'is valid with valid attributes' do
    expect(build(:booking)).to be_valid
  end

  it 'is not valid without a booking_status' do
    booking = build(:booking, booking_status: nil)
    expect(booking).to_not be_valid
  end

  it 'is not valid without a booking_confirmed' do
    booking = build(:booking, booking_confirmed: nil)
    expect(booking).to_not be_valid
  end

  it 'is not valid without a payment_plan' do
    booking = build(:booking, payment_plan: nil)
    expect(booking).to_not be_valid
  end

  it 'is not valid without a installments_paid' do
    booking = build(:booking, installments_paid: nil)
    expect(booking).to_not be_valid
  end

  describe '#confirm_price!' do
    it 'confirms the price' do
      booking = create(:booking)
      booking.confirm_price!
      expect(booking.price_confirmed_at).to_not be_nil
      expect(booking.booking_status).to eq('price_confirmed')
    end
  end

  describe '#complete!' do
    it 'completes the booking' do
      booking = create(:booking)
      booking.complete!
      expect(booking.completed_at).to_not be_nil
      expect(booking.booking_status).to eq('completed')
    end
  end

  describe '#cancel!' do
    it 'cancels the booking' do
      booking = create(:booking)
      booking.cancel!
      expect(booking.cancelled_at).to_not be_nil
      expect(booking.booking_status).to eq('cancelled')
    end
  end

  describe '#flight_offer' do
    it 'returns the flight offer' do
      booking = create(:booking)
      expect(booking.flight_offer).to eq(booking.payment_plan.flight_offer)
    end
  end

  describe '#set_booking_datetime' do
    it 'sets the booking datetime' do
      booking = create(:booking)
      first_datetime = booking.booking_datetime

      booking.set_booking_datetime

      expect(booking.booking_datetime).to_not eq(first_datetime)
    end
  end

  describe '#set_installments_info' do
    it 'sets the installments info' do
      booking = build(:booking, booking_currency: nil, total_installments: nil, installments_amounts: nil)
      booking.set_installments_info
      expect(booking.booking_currency).to eq(booking.payment_plan.installments_currency)
      expect(booking.total_installments).to eq(booking.payment_plan.installments_number)
      expect(booking.installments_amounts).to eq(booking.payment_plan.installments_amounts)
    end
  end
end
