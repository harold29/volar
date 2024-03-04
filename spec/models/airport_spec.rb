require 'rails_helper'

RSpec.describe Airport, type: :model do
  it "is valid with all parameters" do
    country = Country.new(
      name: "Country Name",
      code: "Country Code",
      phone_code: "Country Phone Code",
      language: "Country Language",
      continent: "Country Continent",
      time_zone: "Country Time Zone"
    )

    airport = Airport.new(
      name: "Airport Name",
      city: "Airport City",
      iata_code: "Airport IATA Code",
      icao_code: "Airport ICAO Code",
      time_zone: "Airport Time Zone",
      country: country
    )

    expect(airport).to be_valid
  end

  it "is invalid without a name" do
    airport = Airport.new(name: nil)
    airport.valid?
    expect(airport.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a city" do
    airport = Airport.new(city: nil)
    airport.valid?
    expect(airport.errors[:city]).to include("can't be blank")
  end

  it "is invalid without an IATA code" do
    airport = Airport.new(iata_code: nil)
    airport.valid?
    expect(airport.errors[:iata_code]).to include("can't be blank")
  end

  it "is valid without an ICAO code" do
    airport = Airport.new(icao_code: nil)
    airport.valid?
    expect(airport.errors[:icao_code]).to eq([])
  end

  it "is invalid without a time zone" do
    airport = Airport.new(time_zone: nil)
    airport.valid?
    expect(airport.errors[:time_zone]).to include("can't be blank")
  end
end
