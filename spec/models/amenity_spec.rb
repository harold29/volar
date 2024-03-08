require 'rails_helper'

RSpec.describe Amenity, type: :model do
  it 'is valid with valid attributes' do
    amenity = build(:amenity)
    expect(amenity).to be_valid
  end

  it 'is not valid without a description' do
    amenity = build(:amenity, description: nil)
    expect(amenity).to_not be_valid
  end

  it 'is not valid without a is_chargeable' do
    amenity = build(:amenity, is_chargeable: nil)
    expect(amenity).to_not be_valid
  end

  it 'is not valid without a amenity_type' do
    amenity = build(:amenity, amenity_type: nil)
    expect(amenity).to_not be_valid
  end

  it 'is not valid without a amenity_provider_name' do
    amenity = build(:amenity, amenity_provider_name: nil)
    expect(amenity).to_not be_valid
  end

  it 'is not valid without a fare_details_by_segment' do
    amenity = build(:amenity, fare_details_by_segment: nil)
    expect(amenity).to_not be_valid
  end
end
