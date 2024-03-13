require 'rails_helper'

RSpec.describe Fee, type: :model do
  it 'is valid with valid attributes' do
    expect(build(:fee)).to be_valid
  end

  it 'is not valid without a fee_type' do
    fee = build(:fee, fee_type: nil)
    expect(fee).to_not be_valid
  end

  it 'is not valid without a fee_amount' do
    fee = build(:fee, fee_amount: nil)
    expect(fee).to_not be_valid
  end

  it 'is not valid without a price' do
    fee = build(:fee, price: nil)
    expect(fee).to_not be_valid
  end

  it 'is not valid with a non-numeric fee_amount' do
    fee = build(:fee, fee_amount: 'abc')
    expect(fee).to_not be_valid
  end
end
