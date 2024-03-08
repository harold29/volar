require 'rails_helper'

RSpec.describe FlightFinder do
  describe '#search_flights' do
    let(:flight_finder_params) do
      {
        origin: 'LHR',
        destination: 'CDG',
        departure_date: '2022-01-01',
        return_date: '2022-01-10',
        adults: 2,
        children: 1,
        infants: 1,
        travel_class: 'ECONOMY'
      }
    end

    describe 'when the search is successful' do
      include_context 'get flight offer response'

      subject(:flight_finder) { described_class.new(flight_finder_params) }

      it 'returns the correct response objects' do
        response = flight_finder.search_flights

        expect(response.result).to be_a(Hash)

        expect(response.result['meta']).to be_a(Hash)
        expect(response.result['data']).to be_a(Array)
        expect(response.result['dictionaries']).to be_a(Hash)
      end

      context 'returns the correct response data' do
        it 'returns the correct response data object' do
          response = flight_finder.search_flights

          expect(response.result['data'].size).to eq(4)
          expect(response.result['data'].first['type']).to eq('flight-offer')
          expect(response.result['data'].first['id']).to be_a(String)
          expect(response.result['data'].first['source']).to eq(flight_finder_params[:origin])
          expect(response.result['data'].first['instantTicketingRequired']).to eq(false)
          expect(response.result['data'].first['nonHomogeneous']).to eq(false)
          expect(response.result['data'].first['oneWay']).to eq(false)
          expect(response.result['data'].first['lastTicketingDate']).to eq('2024-03-09')
          expect(response.result['data'].first['numberOfBookableSeats']).to eq(9)
          expect(response.result['data'].first['itineraries']).to be_a(Array)
          expect(response.result['data'].first['price']).to be_a(Hash)
          expect(response.result['data'].first['pricingOptions']).to be_a(Hash)
          expect(response.result['data'].first['validatingAirlineCodes']).to be_a(Array)
          expect(response.result['data'].first['travelerPricings']).to be_a(Array)
        end

        describe 'returns the correct itineraries object' do
          it 'response with correct fields' do
            response = flight_finder.search_flights

            expect(response.result['data'].first['itineraries'].size).to eq(1)
            expect(response.result['data'].first['itineraries'].first['duration']).to eq('PT28H45M')
          end

          it 'returns correct segments' do
            response = flight_finder.search_flights
            segments = response.result['data'].first['itineraries'].first['segments']

            expect(segments).to be_a(Array)
            expect(segments.size).to eq(2)
            expect(segments.first['departure']).to be_a(Hash)
            expect(segments.first['departure']['iataCode']).to eq('EZE')
            expect(segments.first['departure']['at']).to eq("#{flight_finder_params[:departure_date]}T23:55:00")
            expect(segments.first['arrival']).to be_a(Hash)
            expect(segments.first['carrierCode']).to eq('TK')
            expect(segments.first['number']).to eq('16')
            expect(segments.first['aircraft']).to be_a(Hash)
            expect(segments.first['operating']).to be_a(Hash)
            expect(segments.first['duration']).to eq('PT16H45M')
            expect(segments.first['id']).to eq('108')
            expect(segments.first['numberOfStops']).to eq(1)
            expect(segments.first['blacklistedInEU']).to eq(false)
          end
        end
      end
    end
  end
end
