require 'spec_helper'

RSpec.describe ::OfferBuilder do
  # describe '#build_offer' do
  #   let(:flight_finder_params) do
  #     {
  #       origin: 'LHR',
  #       destination: 'CDG',
  #       departure_date: '2025-01-01',
  #       return_date: '2025-01-10',
  #       adults: 2,
  #       children: 1,
  #       infants: 1,
  #       travel_class: 'ECONOMY'
  #     }
  #   end
  #   let(:request_params) do
  #     {
  #       originLocationCode: 'LHR',
  #       destinationLocationCode: 'CDG',
  #       departureDate: '2025-01-01',
  #       returnDate: '2025-01-10',
  #       adults: 2,
  #       children: 1,
  #       infants: 1,
  #       travelClass: 'ECONOMY'
  #     }
  #   end

  #   describe 'when the search is successful' do
  #     let(:payment_plan) { PaymentPlan.find_by(name: 'monthly') }

  #     include_context 'get flight offer response'
  #     include_context 'set countries - currencies - airport - carrier'
  #     include_context 'set payment plans'

  #     subject(:offer_builder) { described_class.new(flight_finder_params) }

  #     it 'returns the correct response objects' do
  #       offer = offer_builder.build

  #       expect(offer).to be_an(Hash)
  #       expect(offer[:payment_plans]).to be_an(Array)
  #       expect(offer[:payment_plans].first).to be_an(Hash)
  #       expect(offer[:payment_plans].first[:payment_plan]).to be_a(String)
  #       expect(offer[:payment_plans].first[:departure_date]).to be_a(String)
  #       expect(offer[:payment_plans].first[:return_date]).to be_a(String)
  #     end

  #     it 'the offer returned contains main request data' do
  #       offer = offer_builder.build

  #       expect(offer[:departure_date]).to eq(request_params[:departureDate])
  #       expect(offer[:return_date]).to eq(request_params[:returnDate])
  #       expect(offer[:adults]).to eq(request_params[:adults])
  #       expect(offer[:children]).to eq(request_params[:children])
  #       expect(offer[:infants]).to eq(request_params[:infants])
  #       expect(offer[:travel_class]).to eq(request_params[:travelClass])
  #     end

  #     it 'the offer returned contains payment plans' do
  #       offer = offer_builder.build

  #       expect(offer[:payment_plans].first[:departure_date]).to eq(request_params[:departureDate])
  #       expect(offer[:payment_plans].first[:return_date]).to eq(request_params[:returnDate])
  #       expect(offer[:payment_plans].first[:installments_number]).to eq(payment_plan.number_of_installments_from_date(request_params[:departureDate]))
  #       expect(offer[:payment_plans].first[:installment_amounts]).to eq(payment_plan.calculate_installment_amounts(
  #                                                                         offer[:payment_plans].first[:flight_offer].price_total, request_params[:departureDate]
  #                                                                       ))
  #     end
  #   end
  # end
end
