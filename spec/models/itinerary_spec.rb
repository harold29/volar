require 'rails_helper'

RSpec.describe Itinerary, type: :model do
  it 'is valid with all attributes' do
    itinerary = Itinerary.new(
      flight_offer: create(:flight_offer),
      duration: "5H35M"
    )
    expect(itinerary).to be_valid
  end

  it 'is invalid without a flight offer' do
    itinerary = Itinerary.new(flight_offer: nil)
    itinerary.valid?
    expect(itinerary.errors[:flight_offer]).to include("must exist")
  end

  it 'is invalid without a duration' do
    itinerary = Itinerary.new(duration: nil)
    itinerary.valid?
    expect(itinerary.errors[:duration]).to include("can't be blank")
  end
end
