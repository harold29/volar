require 'rails_helper'

RSpec.describe AdditionalService, type: :model do
  it 'is valid with valid attributes' do
    expect(build(:additional_service)).to be_valid
  end

  it 'is not valid without a service_type' do
    additional_service = build(:additional_service, service_type: nil)
    expect(additional_service).to_not be_valid
  end

  it 'is not valid without a service_amount' do
    additional_service = build(:additional_service, service_amount: nil)
    expect(additional_service).to_not be_valid
  end

  it 'is not valid without a price' do
    additional_service = build(:additional_service, price: nil)
    expect(additional_service).to_not be_valid
  end

  it 'is not valid with a non-numeric service_amount' do
    additional_service = build(:additional_service, service_amount: 'abc')
    expect(additional_service).to_not be_valid
  end
end
