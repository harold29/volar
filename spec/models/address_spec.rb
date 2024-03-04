require 'rails_helper'

RSpec.describe Address, type: :model do
  let(:profile) { create(:profile) }
  let(:country) { create(:country) }

  it 'is valid with all parameters' do
    address = Address.new(
      profile: profile,
      address_line_1: 'Address Line 1',
      address_line_2: 'Address Line 2',
      city: 'City',
      state: 'State',
      postal_code: 'Postal Code',
      country: country,
      address_type: 0,
      address_verified: false
    )

    expect(address).to be_valid
  end

  it 'is invalid without an address line 1' do
    address = Address.new(address_line_1: nil)
    address.valid?
    expect(address.errors[:address_line_1]).to include("can't be blank")
  end

  it 'is valid without an address line 2' do
    address = Address.new(address_line_2: nil)
    address.valid?
    expect(address.errors[:address_line_2]).to eq([])
  end

  it 'is invalid without a city' do
    address = Address.new(city: nil)
    address.valid?
    expect(address.errors[:city]).to include("can't be blank")
  end

  it 'is invalid without a state' do
    address = Address.new(state: nil)
    address.valid?
    expect(address.errors[:state]).to include("can't be blank")
  end

  it 'is invalid without a postal code' do
    address = Address.new(postal_code: nil)
    address.valid?
    expect(address.errors[:postal_code]).to include("can't be blank")
  end

  it 'is invalid without a type' do
    address = Address.new(address_type: nil)
    address.valid?
    expect(address.errors[:address_type]).to include("can't be blank")
  end

  it 'is invalid without a country' do
    address = Address.new(country: nil)
    address.valid?
    expect(address.errors[:country]).to include("must exist")
  end

  it 'is invalid without a profile' do
    address = Address.new(profile: nil)
    address.valid?
    expect(address.errors[:profile]).to include("must exist")
  end
end
