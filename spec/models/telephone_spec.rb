require 'rails_helper'

RSpec.describe Telephone, type: :model do
  it 'is valid with valid attributes' do
    expect(build(:telephone)).to be_valid
  end

  it 'is not valid without an area_code' do
    telephone = build(:telephone, area_code: nil)
    expect(telephone).to_not be_valid
  end

  it 'is not valid without a phone_number' do
    telephone = build(:telephone, phone_number: nil)
    expect(telephone).to_not be_valid
  end

  it 'is not valid without a phone_type' do
    telephone = build(:telephone, phone_type: nil)
    expect(telephone).to_not be_valid
  end

  it 'is not valid without a user' do
    telephone = build(:telephone, user: nil)
    expect(telephone).to_not be_valid
  end
end
