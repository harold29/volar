require 'rails_helper'

RSpec.describe Airline, type: :model do
  it "is valid with a name and logo" do
    airline = Airline.new(
      name: "Name",
      logo: "Logo"
    )
    expect(airline).to be_valid
  end

  it "is invalid without a name" do
    airline = Airline.new(name: nil)
    airline.valid?
    expect(airline.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a logo" do
    airline = Airline.new(logo: nil)
    airline.valid?
    expect(airline.errors[:logo]).to include("can't be blank")
  end
end
