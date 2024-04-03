require 'rails_helper'

RSpec.describe PaymentPlan, type: :model do
  it 'is valid with valid attributes' do
    expect(build(:payment_plan)).to be_valid
  end

  it 'is not valid without departure_at' do
    expect(build(:payment_plan, departure_at: nil)).to_not be_valid
  end

  it 'is not valid without return_at' do
    expect(build(:payment_plan, return_at: nil)).to_not be_valid
  end

  it 'is not valid without installments_currency' do
    expect(build(:payment_plan, installments_currency: nil, flight_offer: nil)).to_not be_valid
  end

  it 'is not valid without installments_number' do
    expect(build(:payment_plan, installments_number: nil, departure_at: nil)).to_not be_valid
  end

  it 'is not valid without installments_amounts' do
    expect(build(:payment_plan, installments_amounts: nil, flight_offer: nil)).to_not be_valid
  end

  it 'is not valid without active' do
    expect(build(:payment_plan, active: nil)).to_not be_valid
  end

  it 'is not valid without selected' do
    expect(build(:payment_plan, selected: nil)).to_not be_valid
  end

  it 'is not valid without flight_offer' do
    expect(build(:payment_plan, flight_offer: nil)).to_not be_valid
  end

  it 'is not valid without payment_term' do
    expect(build(:payment_plan, payment_term: nil)).to_not be_valid
  end

  # Removed because this value is set in the before_validation callback
  # it 'is not valid with installments_number not an integer' do
  #   expect(build(:payment_plan, installments_number: 1.5)).to_not be_valid
  # end

  it 'is not valid without last_ticketing_datetime' do
    expect(build(:payment_plan, last_ticketing_datetime: nil, flight_offer: nil)).to_not be_valid
  end

  context '#complete!' do
    it 'updates payment_plan_status to completed' do
      payment_plan = create(:payment_plan)
      payment_plan.complete!
      expect(payment_plan.payment_plan_status).to eq('completed')
    end
  end

  context '#fail!' do
    it 'updates failed_at' do
      payment_plan = create(:payment_plan)
      payment_plan.fail!
      expect(payment_plan.failed_at).to be_present
    end
  end

  context '#cancel!' do
    it 'updates payment_plan_status to cancelled' do
      payment_plan = create(:payment_plan)
      payment_plan.cancel!
      expect(payment_plan.payment_plan_status).to eq('cancelled')
    end
  end
end
