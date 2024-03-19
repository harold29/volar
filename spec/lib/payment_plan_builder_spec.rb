require 'rails_helper'

RSpec.describe PaymentPlanBuilder do
  describe '#initialize' do
    let(:user) { create(:user) }
    let(:flight_offers) { [] }
    let(:flight_finder_params) do
      {
        origin: 'LHR',
        destination: 'CDG',
        departure_date: '2025-01-01',
        return_date: '2025-01-10',
        adults: 2,
        children: 1,
        infants: 1,
        travel_class: 'ECONOMY'
      }
    end

    subject(:offer_builder) { described_class.new(user, flight_finder_params, flight_offers) }

    it 'sets the flight_finder_params attribute' do
      expect(offer_builder.instance_variable_get(:@flight_finder_params)).to eq(flight_finder_params)
    end
  end

  describe '#build' do
    let(:user) { create(:user) }
    let(:flight_finder_params) do
      {
        origin: 'LHR',
        destination: 'CDG',
        departure_date: '2025-01-01',
        return_date: '2025-01-10',
        adults: 2,
        children: 1,
        infants: 1,
        travel_class: 'ECONOMY'
      }
    end

    let(:request_params) do
      {
        originLocationCode: 'LHR',
        destinationLocationCode: 'CDG',
        departureDate: '2025-01-01',
        returnDate: '2025-01-10',
        adults: 2,
        children: 1,
        infants: 1,
        travelClass: 'ECONOMY'
      }
    end

    include_context 'get flight offer response'
    include_context 'set countries - currencies - airport - carrier'
    include_context 'set payment terms'
    include_context 'set flight offers in base of response'

    subject(:payment_plan_builder) { described_class.new(user, flight_finder_params, flight_offers) }

    it 'calls the create_payment_plans method' do
      # Is executed the same number of times of flight offers in the response
      expect(payment_plan_builder).to receive(:create_payment_plans).exactly(4).times

      payment_plan_builder.build
    end

    it 'builds the payment plans' do
      payment_plan_builder.build

      payment_plan = PaymentPlan.first
      expect(PaymentPlan.count).to eq(4)
      expect(payment_plan.departure_at.to_s).to eq(request_params[:departureDate])
      expect(payment_plan.return_at.to_s).to eq(request_params[:returnDate])
      expect(payment_plan.installments_number).to eq(payment_plan.payment_term.number_of_installments_from_date(request_params[:departureDate]))
      expect(payment_plan.installment_amounts).to eq(payment_plan.payment_term.calculate_installment_amounts(payment_plan.flight_offer.price_total,
                                                                                                             request_params[:departureDate]))
      expect(payment_plan.last_ticketing_datetime.to_s).to eq('2024-03-09 00:00:00 UTC')
      expect(payment_plan.flight_offer).to be_a(FlightOffer)
      expect(payment_plan.active).to eq(true)
    end

    it 'raises an error if the payment plan cannot be created' do
      allow(payment_plan_builder).to receive(:create_payment_plans).and_raise(ActiveRecord::RecordInvalid)

      expect { payment_plan_builder.build }.to raise_error(described_class::Error)
    end

    it 'raises an error if the payment plan cannot be saved' do
      allow(payment_plan_builder).to receive(:create_payment_plans).and_raise(ActiveRecord::RecordNotSaved)

      expect { payment_plan_builder.build }.to raise_error(described_class::Error)
    end

    it 'raises an error if the payment plan cannot be found' do
      allow(payment_plan_builder).to receive(:create_payment_plans).and_raise(ActiveRecord::RecordNotFound)

      expect(Rails.logger).to receive(:error)
      expect { payment_plan_builder.build }.to raise_error(described_class::Error)
    end

    it 'raises an error if an unexpected error occurs' do
      allow(payment_plan_builder).to receive(:create_payment_plans).and_raise(StandardError)

      expect { payment_plan_builder.build }.to raise_error(described_class::Error)
    end

    it 'logs the error if an unexpected error occurs' do
      allow(payment_plan_builder).to receive(:create_payment_plans).and_raise(StandardError)

      expect(Rails.logger).to receive(:error)
      expect { payment_plan_builder.build }.to raise_error(described_class::Error)
    end

    it 'returns the payment plans' do
      payment_plans = payment_plan_builder.build

      expect(payment_plans).to be_an(Array)
      expect(payment_plans.first.first).to be_a(PaymentPlan)
    end

    it 'returns an empty array if no payment plans are created' do
      allow(payment_plan_builder).to receive(:create_payment_plans).and_return([])

      payment_plans = payment_plan_builder.build

      expect(payment_plans).to eq([])
    end
  end
end
