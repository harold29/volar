require 'rails_helper'

RSpec.describe FlightFinder do
  describe '#search_flights' do
    let(:us_currency) { create(:currency, code: 'USD') }
    let(:flight_finder_params) do
      {
        origin: 'LHR',
        destination: 'CDG',
        departure_date: '2025-01-01',
        return_date: '2025-01-10',
        adults: 2,
        children: 1,
        infants: 1,
        travel_class: 'ECONOMY',
        currency_id: us_currency.id,
        nonstop: 'false',
        one_way: 'false'
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
        travelClass: 'ECONOMY',
        currencyCode: 'USD',
        nonStop: 'false',
        oneWay: 'false'
      }
    end

    describe 'when the search is successful' do
      let(:user) { create(:user) }

      include_context 'get flight offer response'
      include_context 'set countries - currencies - airport - carrier'

      subject(:flight_finder) { described_class.new(user, flight_finder_params) }

      it 'returns the correct response objects' do
        expect(flight_finder.search_flights.flight_offers).to be_an(ActiveRecord::Associations::CollectionProxy)
        expect(flight_finder.search_flights.flight_offers.first).to be_a(FlightOffer)
        expect(flight_finder.search_flights.flight_offers.first.itineraries.first).to be_a(Itinerary)
        expect(flight_finder.search_flights.flight_offers.first.itineraries.first.segments.first).to be_a(Segment)
        expect(flight_finder.search_flights.flight_offers.first.itineraries.first.segments.first.departure_airport).to be_a(Airport)
        expect(flight_finder.search_flights.flight_offers.first.itineraries.first.segments.first.arrival_airport).to be_a(Airport)
        expect(flight_finder.search_flights.flight_offers.first.itineraries.first.segments.first.carrier).to be_a(Carrier)
      end

      it 'creates the correct number of records' do
        expect { flight_finder.search_flights }.to change(FlightOffer, :count).by(4)
                                                                              .and change(Itinerary, :count).by(4)
                                                                                                            .and change(Segment, :count).by(8)
      end

      it 'creates the correct records' do
        flight_finder.search_flights

        expect(FlightOffer.ordered_first.internal_id).to eq('1')
        expect(FlightOffer.ordered_first.source).to eq('LHR')
        expect(FlightOffer.ordered_first.instant_ticketing_required).to eq(false)
        expect(FlightOffer.ordered_first.non_homogeneous).to eq(false)
        expect(FlightOffer.ordered_first.one_way).to eq(false)
        expect(FlightOffer.ordered_first.last_ticketing_date.to_s).to eq('2024-03-09')
        expect(FlightOffer.ordered_first.number_of_bookable_seats).to eq(9)
        expect(FlightOffer.ordered_first.price_total).to eq(733.65)
        expect(FlightOffer.ordered_first.payment_card_required).to eq(false)
        expect(FlightOffer.ordered_first.currency).to eq(Currency.find_by(code: 'EUR'))

        expect(Itinerary.ordered_by_flight_offer_internal_id.first.duration).to eq('PT28H45M')

        expect(Segment.ordered.first.departure_airport).to eq(Airport.find_by(iata_code: 'EZE'))
        expect(Segment.ordered.first.arrival_airport).to eq(Airport.find_by(iata_code: 'IST'))
        expect(Segment.ordered.first.departure_at.to_s).to eq('2025-01-01 23:55:00 UTC')
        expect(Segment.ordered.first.arrival_at.to_s).to eq('2024-05-03 22:40:00 UTC')
        expect(Segment.ordered.first.carrier).to eq(Carrier.find_by(code: 'TK'))
        expect(Segment.ordered.first.flight_number).to eq('16')
      end

      it 'does create duplicate records' do
        flight_finder.search_flights

        expect { flight_finder.search_flights }.to change(FlightOffer, :count)
      end

      it 'raises an error when the response is invalid' do
        allow_any_instance_of(Amadeus::Client).to receive_message_chain(:shopping, :flight_offers_search, :get)
          .and_raise(Amadeus::ResponseError.new(Amadeus::Response.new('500', 'Problem with server')))

        expect { flight_finder.search_flights }.to raise_error(FlightFinder::FlightRetrievingError)
      end

      it 'raises an error when the record is invalid' do
        allow_any_instance_of(FlightSearch).to receive(:save!).and_raise(ActiveRecord::RecordInvalid)

        expect { flight_finder.search_flights }.to raise_error(FlightFinder::Error)
      end

      it 'raises an error when the record is not saved' do
        allow_any_instance_of(FlightSearch).to receive(:save!).and_raise(ActiveRecord::RecordNotSaved)

        expect { flight_finder.search_flights }.to raise_error(FlightFinder::Error)
      end

      it 'raises an error when the record is not found' do
        allow(Airport).to receive(:find_by).and_return(nil)

        expect { flight_finder.search_flights }.to raise_error(FlightFinder::Error)
      end

      it 'raises an error when there is an unhandled error' do
        allow_any_instance_of(FlightOfferParser).to receive(:parse_offer_params).and_raise(StandardError)

        expect { flight_finder.search_flights }.to raise_error(FlightFinder::Error)
      end

      it 'raises an error when there is a record not found' do
        allow(FlightOfferParser).to receive(:parse).and_raise(ActiveRecord::RecordNotFound)

        expect(Rails.logger).to receive(:error).with('Record not found: ActiveRecord::RecordNotFound')
        expect { flight_finder.search_flights }.to raise_error(FlightFinder::Error, 'Required record not found: ActiveRecord::RecordNotFound')
      end
    end
  end
end
