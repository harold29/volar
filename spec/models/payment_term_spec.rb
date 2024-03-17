require 'rails_helper'

RSpec.describe PaymentTerm, type: :model do
  it 'is valid with valid attributes' do
    expect(build(:payment_term)).to be_valid
  end

  it 'is not valid without a name' do
    expect(build(:payment_term, name: nil)).to_not be_valid
  end

  it 'is not valid without a payment_type' do
    expect(build(:payment_term, payment_type: nil)).to_not be_valid
  end

  it 'is not valid without a description' do
    expect(build(:payment_term, description: nil)).to_not be_valid
  end

  it 'is not valid without payment_terms' do
    expect(build(:payment_term, payment_terms: nil)).to_not be_valid
  end

  it 'is not valid without payment_terms_description' do
    expect(build(:payment_term, payment_terms_description: nil)).to_not be_valid
  end

  it 'is not valid without payment_terms_conditions' do
    expect(build(:payment_term, payment_terms_conditions: nil)).to_not be_valid
  end

  it 'is not valid without payment_terms_conditions_url' do
    expect(build(:payment_term, payment_terms_conditions_url: nil)).to_not be_valid
  end

  it 'is not valid without payment_terms_file' do
    expect(build(:payment_term, payment_terms_file: nil)).to_not be_valid
  end

  it 'is not valid without payment_terms_file_url' do
    expect(build(:payment_term, payment_terms_file_url: nil)).to_not be_valid
  end

  it 'is not valid without active' do
    expect(build(:payment_term, active: nil)).to_not be_valid
  end

  it 'is not valid without deleted' do
    expect(build(:payment_term, deleted: nil)).to_not be_valid
  end

  it 'is not valid without days_max_number' do
    expect(build(:payment_term, days_max_number: nil)).to_not be_valid
  end

  it 'is not valid without days_min_number' do
    expect(build(:payment_term, days_min_number: nil)).to_not be_valid
  end

  it 'is not valid without payment_period_in_days' do
    expect(build(:payment_term, payment_period_in_days: nil)).to_not be_valid
  end

  it 'is not valid without interest_rate' do
    expect(build(:payment_term, interest_rate: nil)).to_not be_valid
  end

  it 'is not valid without penalty_rate' do
    expect(build(:payment_term, penalty_rate: nil)).to_not be_valid
  end

  it 'is not valid without installments_max_number' do
    expect(build(:payment_term, installments_max_number: nil)).to_not be_valid
  end

  it 'is not valid without installments_min_number' do
    expect(build(:payment_term, installments_min_number: nil)).to_not be_valid
  end

  it 'is not valid without installments' do
    expect(build(:payment_term, installments: nil)).to_not be_valid
  end

  it 'is not valid without active' do
    expect(build(:payment_term, active: nil)).to_not be_valid
  end

  it 'is not valid without deleted' do
    expect(build(:payment_term, deleted: nil)).to_not be_valid
  end

  describe '#date_comply_with_payment_terms?' do
    let(:payment_term) { build(:payment_term, installments_max_number: 25) }

    it 'returns false if the date is before the min_number_of_days' do
      expect(payment_term.date_comply_with_payment_terms?(Date.today - 1)).to be_falsey
    end

    it 'returns false if the date is after the max_number_of_days' do
      expect(payment_term.date_comply_with_payment_terms?(Date.today + 31)).to be_falsey
    end

    it 'returns true if the date is between the min_number_of_days and max_number_of_days' do
      expect(payment_term.date_comply_with_payment_terms?(Date.today + 20)).to be_truthy
    end
  end

  describe '#number_of_installments_from_date' do
    let(:payment_term) { build(:payment_term, payment_period_in_days: 5) }

    it 'returns 0 if the date is before the min_number_of_days' do
      expect(payment_term.number_of_installments_from_date(Date.today - 1)).to eq(0)
    end

    it 'returns 0 if the date is after the max_number_of_days' do
      expect(payment_term.number_of_installments_from_date(Date.today + 31)).to eq(0)
    end

    it 'returns the number of installments if the date is between the min_number_of_days and max_number_of_days' do
      expect(payment_term.number_of_installments_from_date(Date.today + 20)).to eq(4)
    end
  end

  describe '#calculate_installment_amounts' do
    let(:payment_term) { build(:payment_term, payment_period_in_days: 5, interest_rate: 0.1) }

    it 'returns an array of installment amounts' do
      expect(payment_term.calculate_installment_amounts(100, Date.today + 20)).to eq([27, 27, 27, 29].map(&:to_d))
    end

    it 'returns an array of installment amounts with the last installment amount increased' do
      expect(payment_term.calculate_installment_amounts(100, Date.today + 31)).to eq([18, 18, 18, 18, 18, 20].map(&:to_d))
    end
  end
end
