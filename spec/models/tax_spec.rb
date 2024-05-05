require 'rails_helper'

RSpec.describe Tax, type: :model do
  it 'is valid with valid attributes' do
    expect(build(:tax)).to be_valid
  end

  it 'is not valid without a price' do
    tax = build(:tax, price: nil)
    expect(tax).to_not be_valid
  end

  it 'is not valid without a tax_code' do
    tax = build(:tax, tax_code: nil)
    expect(tax).to_not be_valid
  end

  it 'is not valid without a tax_amount' do
    tax = build(:tax, tax_amount: nil)
    expect(tax).to_not be_valid
  end
end
