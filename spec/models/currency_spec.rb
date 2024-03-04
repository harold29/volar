require 'rails_helper'

RSpec.describe Currency, type: :model do
  let(:country) { create(:country)}
  it "is valid with all parameters" do
    currency = Currency.new(
      name: "MyString",
      code: "MyString",
      symbol: "MyString",
      country: country
    )
    expect(currency).to be_valid
  end

  it "is invalid without a name" do
    currency = Currency.new(name: nil, country: country)
    currency.valid?
    expect(currency.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a code" do
    currency = Currency.new(code: nil, country: country)
    currency.valid?
    expect(currency.errors[:code]).to include("can't be blank")
  end

  it "is invalid without a symbol" do
    currency = Currency.new(symbol: nil, country: country)
    currency.valid?
    expect(currency.errors[:symbol]).to include("can't be blank")
  end

  it "is invalid without a country" do
    currency = Currency.new(name: "MyString", code: "MyString", symbol: "MyString")
    currency.valid?
    expect(currency.errors[:country]).to include("must exist")
  end

end
