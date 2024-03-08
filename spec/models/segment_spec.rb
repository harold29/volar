require 'rails_helper'

RSpec.describe Segment, type: :model do
  it 'is valid with all attributes' do
    segment = Segment.new(
      itinerary: create(:itinerary),
      departure_airport: create(:airport),
      arrival_airport: create(:airport),
      departure_at: Time.now,
      arrival_at: Time.now + 2.hours,
      carrier: create(:carrier),
      flight_number: '123',
      aircraft_code: 'ABC',
      duration: '2H',
      stops_number: 0
    )
    expect(segment).to be_valid
  end

  it 'is invalid without an itinerary' do
    segment = Segment.new(itinerary: nil)
    segment.valid?
    expect(segment.errors[:itinerary]).to include('must exist')
  end

  it 'is invalid without a departure airport' do
    segment = Segment.new(departure_airport: nil)
    segment.valid?
    expect(segment.errors[:departure_airport]).to include('must exist')
  end

  it 'is invalid without an arrival airport' do
    segment = Segment.new(arrival_airport: nil)
    segment.valid?
    expect(segment.errors[:arrival_airport]).to include('must exist')
  end

  it 'is invalid without a departure at' do
    segment = Segment.new(departure_at: nil)
    segment.valid?
    expect(segment.errors[:departure_at]).to include("can't be blank")
  end

  it 'is invalid without an arrival at' do
    segment = Segment.new(arrival_at: nil)
    segment.valid?
    expect(segment.errors[:arrival_at]).to include("can't be blank")
  end

  it 'is invalid without a carrier' do
    segment = Segment.new(carrier: nil)
    segment.valid?
    expect(segment.errors[:carrier]).to include('must exist')
  end

  it 'is invalid without a flight number' do
    segment = Segment.new(flight_number: nil)
    segment.valid?
    expect(segment.errors[:flight_number]).to include("can't be blank")
  end

  it 'is invalid without a duration' do
    segment = Segment.new(duration: nil)
    segment.valid?
    expect(segment.errors[:duration]).to include("can't be blank")
  end

  it 'is invalid without a stops number' do
    segment = Segment.new(stops_number: nil)
    segment.valid?
    expect(segment.errors[:stops_number]).to include('is not a number')
  end

  it 'is invalid with a negative stops number' do
    segment = Segment.new(stops_number: -1)
    segment.valid?
    expect(segment.errors[:stops_number]).to include('must be greater than or equal to 0')
  end

  it 'is invalid with a non-integer stops number' do
    segment = Segment.new(stops_number: 1.5)
    segment.valid?
    expect(segment.errors[:stops_number]).to include('must be an integer')
  end

  it 'is invalid with a non-integer stops number' do
    segment = Segment.new(stops_number: 1.5)
    segment.valid?
    expect(segment.errors[:stops_number]).to include('must be an integer')
  end
end
