require 'rails_helper'

RSpec.describe 'FlightSearches', type: :request do
  # TODO: Improve tests
  describe 'POST /create' do
    include_context 'get flight offer response'
    include_context 'set countries - currencies - airport - carrier'

    let(:us_currency) { create(:currency, code: 'USD') }

    let(:request_params) do
      {
        originLocationCode: 'LHR',
        destinationLocationCode: 'CDG',
        departureDate: Date.today.to_s,
        returnDate: (Date.today + 1.week).to_s,
        adults: 2,
        children: 1,
        infants: 1,
        travelClass: 'ECONOMY',
        nonStop: false,
        currencyCode: 'USD'
      }
    end
    let(:flight_finder_params) do
      {
        origin: 'LHR',
        destination: 'CDG',
        departure_date: Date.today.to_s,
        return_date: (Date.today + 1.week).to_s,
        adults: 2,
        children: 1,
        infants: 1,
        travel_class: 'ECONOMY',
        nonstop: false,
        currency_id: us_currency.id
      }
    end
    let(:invalid_flight_finder_params) do
      {
        origin: '',
        destination: '',
        departure_date: '',
        return_date: '',
        adults: '',
        children: '',
        infants: '',
        travel_class: '',
        nonstop: '',
        currency_id: ''
      }
    end

    let(:user) { create(:user) }

    it 'creates a new flight search' do
      user

      post flight_searches_url, params: { flight_search: flight_finder_params }, as: :json
      expect(response).to be_created
    end

    it 'creates a new flight search with valid attributes' do
      user
      post flight_searches_url,
           params: {
             flight_search: {
               origin: 'LHR',
               destination: 'CDG',
               departure_date: Date.today.to_s,
               return_date: (Date.today + 1.week).to_s,
               adults: 2,
               children: 1,
               infants: 1,
               travel_class: 'ECONOMY',
               nonstop: false,
               currency_id: us_currency.id
             }
           }, as: :json
      expect(response).to be_created
    end

    # it 'does not create a new flight search with invalid attributes' do
    #   user
    #   post flight_searches_url,
    #        params: {
    #          flight_search: {
    #            origin: '',
    #            destination: '',
    #            departure_date: '',
    #            return_date: '',
    #            adults: '',
    #            children: '',
    #            infants: '',
    #            travel_class: '',
    #            nonstop: '',
    #            currency_id: ''
    #          }
    #        }, as: :json
    #   expect(response).to render_template(:new)
    # end

    it 'does not create a new flight search with invalid attributes' do
      post flight_searches_url, params: { flight_search: invalid_flight_finder_params }, as: :json
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'GET /show' do
    let(:flight_search_with_offers) { create(:flight_search_with_flight_offers) }

    it 'returns http success' do
      get flight_search_url(flight_search_with_offers), as: :json
      expect(response).to have_http_status(:success)
    end

    # it 'renders the show template' do
    #   get flight_search_url(flight_search_with_offers), as: :json
    #   expect(response).to render_template(:show)
    # end
  end

  describe 'GET /index' do
    it 'returns http success' do
      get flight_searches_url, as: :json
      expect(response).to have_http_status(:success)
    end

    # it 'renders the index template' do
    #   get flight_searches_url, as: :json
    #   expect(response).to render_template(:index)
    # end
  end

  # describe 'GET /search' do
  # it 'returns http success' do
  # get '/flight_search/search'
  # expect(response).to have_http_status(:success)
  # end
  # end
end
