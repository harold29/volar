require 'rails_helper'

RSpec.describe Stop, type: :model do
  it 'is valid with valid attributes' do
    expect(build(:stop)).to be_valid
  end

  it 'is not valid without a segment' do
    stop = build(:stop, segment: nil)
    expect(stop).to_not be_valid
  end

  it 'is not valid without an airport' do
    stop = build(:stop, airport: nil)
    expect(stop).to_not be_valid
  end

  it 'is not valid without a duration' do
    stop = build(:stop, duration: nil)
    expect(stop).to_not be_valid
  end

  it 'is not valid without an arrival_at' do
    stop = build(:stop, arrival_at: nil)
    expect(stop).to_not be_valid
  end

  it 'is not valid without a departure_at' do
    stop = build(:stop, departure_at: nil)
    expect(stop).to_not be_valid
  end
end
