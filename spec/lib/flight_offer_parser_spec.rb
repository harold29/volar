require 'rails_helper'

RSpec.describe FlightOfferParser do
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
  let(:flight_search) { create(:flight_search) }

  include_context 'get only flight offer response'
  include_context 'set countries - currencies - airport - carrier'

  it 'parses the response and creates the flight offers' do
    flight_offers = FlightOfferParser.parse(parsed_response, flight_search)

    expect(flight_offers.size).to eq(4)
    expect(flight_offers.first).to be_a(FlightOffer)
    expect(flight_offers.first.internal_id).to eq('1')
    expect(flight_offers.first.source).to eq('LHR')
    expect(flight_offers.first.instant_ticketing_required).to eq(false)
    expect(flight_offers.first.non_homogeneous).to eq(false)
    expect(flight_offers.first.one_way).to eq(false)
    expect(flight_offers.first.last_ticketing_date.to_s).to eq('2024-03-09')
    expect(flight_offers.first.last_ticketing_datetime.to_s).to eq('2024-03-09 00:00:00 UTC')
    expect(flight_offers.first.number_of_bookable_seats).to eq(9)
    expect(flight_offers.first.price_total).to eq(733.65)
    expect(flight_offers.first.payment_card_required).to eq(false)
    expect(flight_offers.first.currency).to be_a(Currency)
    expect(flight_offers.first.itineraries.size).to eq(1)
    expect(flight_offers.first.traveler_pricings.size).to eq(1)
  end

  it 'parses the itineraries' do
    flight_offers = FlightOfferParser.parse(parsed_response, flight_search)

    expect(flight_offers.first.itineraries.size).to eq(1)
    expect(flight_offers.first.itineraries.first).to be_a(Itinerary)
    expect(flight_offers.first.itineraries.first.duration).to eq('PT28H45M')
    expect(flight_offers.first.itineraries.first.segments.size).to eq(2)
  end

  it 'parses the segments' do
    flight_offers = FlightOfferParser.parse(parsed_response, flight_search)

    expect(flight_offers.first.itineraries.first.segments.size).to eq(2)
    expect(flight_offers.first.itineraries.first.segments.first).to be_a(Segment)
    expect(flight_offers.first.itineraries.first.segments.first.departure_airport).to be_a(Airport)
    expect(flight_offers.first.itineraries.first.segments.first.arrival_airport).to be_a(Airport)
    expect(flight_offers.first.itineraries.first.segments.first.departure_at.to_s).to eq("#{flight_finder_params[:departure_date]} 23:55:00 UTC")
    expect(flight_offers.first.itineraries.first.segments.first.arrival_at.to_s).to eq('2024-05-03 22:40:00 UTC')
    expect(flight_offers.first.itineraries.first.segments.first.carrier).to be_a(Carrier)
    expect(flight_offers.first.itineraries.first.segments.first.flight_number).to eq('16')
    expect(flight_offers.first.itineraries.first.segments.first.aircraft_code).to eq('359')
    expect(flight_offers.first.itineraries.first.segments.first.duration).to eq('PT16H45M')
    expect(flight_offers.first.itineraries.first.segments.first.stops_number).to eq(1)
    expect(flight_offers.first.itineraries.first.segments.first.blacklisted_in_eu).to eq(false)
    expect(flight_offers.first.itineraries.first.segments.first.stops.size).to eq(1)
  end

  it 'parses the stops' do
    flight_offers = FlightOfferParser.parse(parsed_response, flight_search)

    expect(flight_offers.first.itineraries.first.segments.first.stops.size).to eq(1)
    expect(flight_offers.first.itineraries.first.segments.first.stops.first).to be_a(Stop)
    expect(flight_offers.first.itineraries.first.segments.first.stops.first.airport).to be_a(Airport)
    expect(flight_offers.first.itineraries.first.segments.first.stops.first.duration).to eq('PT1H35M')
    expect(flight_offers.first.itineraries.first.segments.first.stops.first.arrival_at.to_s).to eq('2024-05-03 02:30:00 UTC')
    expect(flight_offers.first.itineraries.first.segments.first.stops.first.departure_at.to_s).to eq('2024-05-03 04:05:00 UTC')
  end

  it 'does not create the flight offer if the currency is not found' do
    parsed_response.first['price']['currency'] = 'XXX'

    expect { FlightOfferParser.parse(parsed_response, flight_search) }.to raise_error(FlightOfferParser::Error)
  end

  it 'does not create the flight offer if the airport is not found' do
    parsed_response.first['itineraries'].first['segments'].first['departure']['iata_code'] = 'XXX'

    expect { FlightOfferParser.parse(parsed_response, flight_search) }.to raise_error(FlightOfferParser::Error)
  end

  it 'does not create the flight offer if the carrier is not found' do
    parsed_response.first['itineraries'].first['segments'].first['carrier_code'] = 'XXX'

    expect { FlightOfferParser.parse(parsed_response, flight_search) }.to raise_error(FlightOfferParser::Error)
  end

  it 'does not create the flight offer if the stop airport is not found' do
    parsed_response.first['itineraries'].first['segments'].first['stops'].first['iata_code'] = 'XXX'

    expect { FlightOfferParser.parse(parsed_response, flight_search) }.to raise_error(FlightOfferParser::Error)
  end
end
