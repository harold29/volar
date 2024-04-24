require 'rails_helper'

RSpec.describe FlightPricing::Validator do
  describe '#validate' do
    subject { described_class.new(flight_offers).validate }

    let(:flight_offers) { [flight_offer] }
    let(:flight_offer) { create(:flight_offer) }
    let(:request_params) { { data: { type: 'flight-offers-pricing', flightOffers: [flight_offer] } } }
    let(:general_parameters) do
      {
        # origin: flight_offer.
      }
    end

    before do
      # allow_any_instance_of(Amadeus::Client).to receive(:post_flight_pricing).and_return(response)
    end

    context 'when the request is successful' do
      let(:response) { double(body: { 'data' => 'success' }) }

      it 'returns the response body' do
        expect(subject).to eq('success')
      end
    end

    context 'when the request fails' do
      let(:response) { double(body: { 'errors' => 'error' }) }

      it 'returns the response body' do
        expect(subject).to eq('error')
      end
    end
  end
end
