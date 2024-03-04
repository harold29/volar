require 'rails_helper'

RSpec.describe Country, type: :model do
  it "is valid with all parameters" do
    country = Country.new(
      name: "Country Name",
      code: "Country Code",
      phone_code: "Country Phone Code",
      language: "Country Language",
      continent: "Country Continent",
      time_zone: "Country Time Zone"
    )
    expect(country).to be_valid
  end

  it "is invalid without a name" do
    country = Country.new(name: nil)
    country.valid?
    expect(country.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a code" do
    country = Country.new(code: nil)
    country.valid?
    expect(country.errors[:code]).to include("can't be blank")
  end

  it "is invalid without a phone code" do
    country = Country.new(phone_code: nil)
    country.valid?
    expect(country.errors[:phone_code]).to include("can't be blank")
  end

  it "is invalid without a language" do
    country = Country.new(language: nil)
    country.valid?
    expect(country.errors[:language]).to include("can't be blank")
  end

  it "is invalid without a continent" do
    country = Country.new(continent: nil)
    country.valid?
    expect(country.errors[:continent]).to include("can't be blank")
  end
end
