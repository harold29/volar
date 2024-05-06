require 'rails_helper'

RSpec.describe 'FlightSearches', type: :request do
  describe 'GET /new' do
    it 'returns http success' do
      get new_flight_search_url
      expect(response).to have_http_status(:success)
    end

    it 'renders the new template' do
      get new_flight_search_url
      expect(response).to render_template(:new)
    end

    it 'assigns a new flight search' do
      get new_flight_search_url
      expect(assigns(:flight_search)).to be_a_new(FlightSearch)
    end
  end

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
      post flight_searches_url,
           params: {
             flight_search: {
               origin: 'LHR',
               destination: 'CDG',
               departure_date: Date.today.to_s,
               return_date: (Date.today + 1.week).to_s,
               passengers: 4,
               adults: 2,
               children: 1,
               infants: 1,
               travel_class: 'ECONOMY',
               nonstop: false,
               currency_id: us_currency.id,
               one_way: false/
             }
           }
      expect(response).to redirect_to(flight_search_url(FlightSearch.last))
    end

    it 'does not create a new flight search with invalid attributes' do
      user
      post flight_searches_url,
           params: {
             flight_search: {
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
           }
      expect(response).to render_template(:new)
    end

    it 'does not create a new flight search with invalid attributes' do
      post flight_searches_url,
           params: {
             flight_search: {
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
           }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'GET /show' do
    let(:flight_search_with_offers) { create(:flight_search_with_flight_offers) }

    it 'returns http success' do
      get flight_search_url(flight_search_with_offers)
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get flight_search_url(flight_search_with_offers)
      expect(response).to render_template(:show)
    end

    it 'assigns the flight search' do
      get flight_search_url(flight_search_with_offers)
      expect(assigns(:flight_search)).to eq(flight_search_with_offers)
    end
  end

  describe 'GET /index' do
    it 'returns http success' do
      get flight_searches_url
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get flight_searches_url
      expect(response).to render_template(:index)
    end

    it 'assigns flight searches' do
      flight_searches = create_list(:flight_search, 3)
      get flight_searches_url
      expect(assigns(:flight_searches)).to eq(flight_searches)
    end
  end

  # describe 'GET /search' do
  # it 'returns http success' do
  # get '/flight_search/search'
  # expect(response).to have_http_status(:success)
  # end
  # end
end
