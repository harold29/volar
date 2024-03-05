require 'rails_helper'

RSpec.describe PaymentPlan, type: :model do
  it 'is valid with valid attributes' do
    expect(build(:payment_plan)).to be_valid
  end

  it 'is not valid without a name' do
    expect(build(:payment_plan, name: nil)).to_not be_valid
  end

  it 'is not valid without a payment_type' do
    expect(build(:payment_plan, payment_type: nil)).to_not be_valid
  end

  it 'is not valid without a description' do
    expect(build(:payment_plan, description: nil)).to_not be_valid
  end

  it 'is not valid without payment_terms' do
    expect(build(:payment_plan, payment_terms: nil)).to_not be_valid
  end

  it 'is not valid without payment_terms_description' do
    expect(build(:payment_plan, payment_terms_description: nil)).to_not be_valid
  end

  it 'is not valid without payment_terms_conditions' do
    expect(build(:payment_plan, payment_terms_conditions: nil)).to_not be_valid
  end

  it 'is not valid without payment_terms_conditions_url' do
    expect(build(:payment_plan, payment_terms_conditions_url: nil)).to_not be_valid
  end

  it 'is not valid without payment_terms_conditions_file' do
    expect(build(:payment_plan, payment_terms_conditions_file: nil)).to_not be_valid
  end

  it 'is not valid without payment_terms_conditions_file_url' do
    expect(build(:payment_plan, payment_terms_conditions_file_url: nil)).to_not be_valid
  end
end
