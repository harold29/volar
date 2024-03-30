require 'rails_helper'
require 'amadeus/errors'

RSpec.describe Amadeus::Client do
  let(:client) { Amadeus::Client.new }
  let(:us_currency) { create(:currency, code: 'USD') }

  describe '#get_flight_offers' do
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
        nonStop: 'false'
      }
    end

    include_context 'get flight offer response'

    it 'returns a response object' do
      expect(client.get_flight_offers(flight_finder_params)).to be_a(Amadeus::Response)
    end

    it 'calls the correct endpoint' do
      connection = double('connection')
      response = double('response', body: '{"data": {"flights": []}, "meta": {"count": 0}}', status: 200)

      allow(client).to receive(:connection).and_return(connection)

      expect(connection).to receive(:get).with('/v2/shopping/flight-offers').and_return(response)

      client.get_flight_offers(flight_finder_params)
    end

    it 'serializes the request params' do
      expect(Amadeus::RequestParamsSerializer).to receive(:serialize).with(flight_finder_params).and_return(request_params)
      client.get_flight_offers(flight_finder_params)
    end

    it 'returns the correct data' do
      flight_offers = JSON.parse(render_custom_response('amadeus/get_flight_offer_response.json.erb', flight_finder_params))['data']
      expect(client.get_flight_offers(flight_finder_params).data).to eq(flight_offers)
    end

    it 'raises an error if the response status is 400' do
      response = double('response', body: '{"errors": [{}]}', status: 400)
      allow(client).to receive(:connection).and_return(double('connection', get: response))

      expect { client.get_flight_offers(flight_finder_params) }.to raise_error(Amadeus::RequestError)
    end

    it 'raises an error if the response status is 401' do
      response = double('response', body: '{"errors": [{}]}', status: 401)
      allow(client).to receive(:connection).and_return(double('connection', get: response))

      expect { client.get_flight_offers(flight_finder_params) }.to raise_error(Amadeus::RequestError)
    end

    it 'raises an error if the response status is 403' do
      response = double('response', body: '{"errors": [{}]}', status: 403)
      allow(client).to receive(:connection).and_return(double('connection', get: response))

      expect { client.get_flight_offers(flight_finder_params) }.to raise_error(Amadeus::RequestError)
    end

    it 'raises an error if the response status is 404' do
      response = double('response', body: '{"errors": [{}]}', status: 404)
      allow(client).to receive(:connection).and_return(double('connection', get: response))

      expect { client.get_flight_offers(flight_finder_params) }.to raise_error(Amadeus::RequestError)
    end

    it 'raises an error if the response status is 500' do
      response = double('response', body: '{"errors": [{}]}', status: 500)
      allow(client).to receive(:connection).and_return(double('connection', get: response))

      expect { client.get_flight_offers(flight_finder_params) }.to raise_error(Amadeus::ServerError)
    end

    it 'raises an error if the response status is unknown' do
      response = double('response', body: '{"errors": [{}]}', status: 300)
      allow(client).to receive(:connection).and_return(double('connection', get: response))

      expect { client.get_flight_offers(flight_finder_params) }.to raise_error(Amadeus::UnknownError)
    end

    it 'raises an error if the response is nil' do
      allow(client).to receive(:connection).and_return(double('connection', get: nil))

      expect { client.get_flight_offers(flight_finder_params) }.to raise_error(Amadeus::ResponseError)
    end

    it 'raises an error if the response body is nil' do
      response = double('response', body: nil, status: 200)
      allow(client).to receive(:connection).and_return(double('connection', get: response))

      expect { client.get_flight_offers(flight_finder_params) }.to raise_error(Amadeus::ResponseError)
    end

    it 'raises an error if the response body is not valid JSON' do
      response = double('response', body: 'invalid json', status: 200)
      allow(client).to receive(:connection).and_return(double('connection', get: response))

      expect { client.get_flight_offers(flight_finder_params) }.to raise_error(Amadeus::ResponseError)
    end

    it 'raises an error if the response is not a valid JSON' do
      response = double('response', body: 'invalid json', status: 200)
      allow(client).to receive(:connection).and_return(double('connection', get: response))

      expect { client.get_flight_offers(flight_finder_params) }.to raise_error(Amadeus::ResponseError)
    end
  end

  describe '#post_flight_offers' do
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
        nonStop: 'false'
      }
    end

    include_context 'post flight offer response'

    it 'calls the correct endpoint' do
      connection = double('connection')
      response = double('response', body: '{"data": {"flights": []}, "meta": {"count": 0}}', status: 200)

      allow(client).to receive(:connection).and_return(connection)

      expect(connection).to receive(:post).with('/v2/shopping/flight-offers').and_return(response)

      client.post_flight_offers(flight_finder_params)
    end

    it 'returns the correct data' do
      flight_offers = JSON.parse(render_custom_response('amadeus/get_flight_offer_response.json.erb', flight_finder_params))['data']
      expect(client.post_flight_offers(flight_finder_params).data).to eq(flight_offers)
    end
  end

  describe '#post_confirm_price_and_availability' do
  end
end
