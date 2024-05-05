require 'rails_helper'

RSpec.describe FlightPricing::ResponseParser do
  let(:us_currency) { create(:currency, code: 'USD') }
  let(:client) { Amadeus::Client.new }
  let(:flight_offer) { create(:flight_offer) }
  let(:general_parameters) do
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
  let(:include_bags) { false }
  let(:include_additional_services) { false }

  include_context 'set countries - currencies - airport - carrier'
  include_context 'post flight offer request and response no include'

  let(:fixed_request) { {} } # Used in shared context to send request
  let(:response) { client.post_flight_pricing(fixed_request, include_bags: false, include_additional_services: false) }
  let(:response_to_compare) { JSON.parse(fixed_response) }
  let(:response_data) { response_to_compare['data']['flightOffers'].first }

  let(:parsed_response) { described_class.parse(response.data, flight_offer) }

  describe '.parse' do
    context 'when response is valid' do
      it 'returns a hash with flight offers' do
        expect(parsed_response).to be_a(Array)
        expect(parsed_response.count).to eq(1)
        expect(parsed_response.first).to include({
                                                   internal_id: response_data['id'].to_s,
                                                   source: response_data['source'],
                                                   last_ticketing_date: response_data['lastTicketingDate'],
                                                   pricing_options_fare_type: response_data['pricingOptions']['fareType'],
                                                   price_total: response_data['price']['total'],
                                                   validating_airline_codes: response_data['validatingAirlineCodes']
                                                 })
      end

      it 'returns a hash with price' do
        price = parsed_response.first[:price_attributes]
        response_price = response_data['price']

        # binding.pry
        expect(price).to include({
                                   price_total: response_price['total'],
                                   base_fare: response_price['base'],
                                   price_grand_total: response_price['grandTotal'],
                                   price_currency_id: a_kind_of(String),
                                   fees_attributes: a_kind_of(Array)
                                 })
      end

      it 'returns a hash with price fees' do
        fees = parsed_response.first[:price_attributes][:fees_attributes]
        response_fees = response_data['price']['fees']

        expect(fees).to be_a(Array)
        expect(fees.count).to eq(3)

        fees.each_with_index do |fee, index|
          response_fee = response_fees[index]

          expect(fee).to include({
                                   fee_amount: response_fee['amount'],
                                   fee_type: response_fee['type']
                                 })
        end
      end

      it 'returns a hash with itineraries' do
        itineraries = parsed_response.first[:itineraries_attributes]

        expect(itineraries).to be_a(Array)
        expect(itineraries.count).to eq(2)

        itineraries.each_with_index do |itinerary, _|
          expect(itinerary).to include({
                                         segments_attributes: a_kind_of(Array)
                                       })
        end
      end

      it 'returns a hash with segments' do
        segments = parsed_response.first[:itineraries_attributes].first[:segments_attributes]

        expect(segments).to be_a(Array)
        expect(segments.count).to eq(2)

        segments.each_with_index do |segment, index|
          expect(segment).to include({
                                       departure_airport: a_kind_of(Airport),
                                       arrival_airport: a_kind_of(Airport),
                                       departure_at: response_data['itineraries'].first['segments'][index]['departure']['at'],
                                       arrival_at: response_data['itineraries'].first['segments'][index]['arrival']['at'],
                                       flight_number: response_data['itineraries'].first['segments'][index]['number'],
                                       aircraft_code: response_data['itineraries'].first['segments'][index]['aircraft']['code'],
                                       duration: response_data['itineraries'].first['segments'][index]['duration'],
                                       stops_number: response_data['itineraries'].first['segments'][index]['numberOfStops'],
                                       internal_id: response_data['itineraries'].first['segments'][index]['id'].to_s
                                     })
        end
      end

      it 'returns a hash with traveler pricings' do
        traveler_pricings = parsed_response.first[:traveler_pricings_attributes]

        expect(traveler_pricings).to be_a(Array)
        expect(traveler_pricings.count).to eq(2)

        traveler_pricings.each_with_index do |traveler_pricing, index|
          response_traveler_pricing = response_data['travelerPricings'][index]

          expect(traveler_pricing).to include({
                                                traveler_internal_id: response_traveler_pricing['travelerId'],
                                                fare_option: response_traveler_pricing['fareOption'],
                                                traveler_type: response_traveler_pricing['travelerType'],
                                                price_attributes: a_kind_of(Hash),
                                                fare_details_by_segments_attributes: a_kind_of(Array)
                                              })
        end
      end

      it 'returns a hash with traveler pricings price' do
        price = parsed_response.first[:traveler_pricings_attributes].first[:price_attributes]

        response_traveler_pricing_price = response_data['travelerPricings'].first['price']

        expect(price).to include({
                                   price_total: response_traveler_pricing_price['total'],
                                   price_currency_id: a_kind_of(String),
                                   base_fare: response_traveler_pricing_price['base'],
                                   refundable_taxes: response_traveler_pricing_price['refundableTaxes'],
                                   taxes_attributes: a_kind_of(Array)
                                 })
      end

      it 'returns a hash with traveler pricings price taxes' do
        taxes = parsed_response.first[:traveler_pricings_attributes].first[:price_attributes][:taxes_attributes]

        response_price_taxes = response_data['travelerPricings'].first['price']['taxes']

        expect(taxes).to be_a(Array)
        expect(taxes.count).to eq(11)

        taxes.each_with_index do |tax, index|
          response_tax = response_price_taxes[index]

          expect(tax).to include({
                                   tax_code: response_tax['code'],
                                   tax_amount: response_tax['amount']
                                 })
        end
      end
    end
  end
end
