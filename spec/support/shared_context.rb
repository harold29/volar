RSpec.shared_context 'get flight offer response' do
  let(:rheaders) { { "Content-Type": 'application/vnd.amadeus+json' } }
  let(:oauth_response) do
    {
      "type": 'amadeusOAuth2Token',
      "username": 'test@test.com',
      "application_name": 'volartestapp',
      "client_id": '12345',
      "token_type": 'Bearer',
      "access_token": 'token',
      "expires_in": 1799,
      "state": 'approved',
      "scope": ''
    }
  end

  before do
    response = render_custom_response('amadeus/flight_offers/responses/get.json.erb', flight_finder_params)

    stub_request(:post, 'https://test.api.amadeus.com/v1/security/oauth2/token')
      .to_return(status: 200, body: oauth_response.to_json, headers: rheaders)

    stub_request(:get, "https://test.api.amadeus.com/v2/shopping/flight-offers?#{build_query_string(request_params)}")
      .to_return(status: 200, body: response, headers: rheaders)
  end
end

RSpec.shared_context 'post flight pricing response no include' do
  let(:rheaders) { { "Content-Type": 'application/json' } }
  let(:oauth_response) do
    {
      "type": 'amadeusOAuth2Token',
      "username": 'test@test.com',
      "application_name": 'volartestapp',
      "client_id": '12345',
      "token_type": 'Bearer',
      "access_token": 'token',
      "expires_in": 1799,
      "state": 'approved',
      "scope": ''
    }
  end

  before do
    response = render_custom_response('amadeus/flight_pricing/responses/post_no_include.json.erb', general_parameters)

    stub_request(:post, 'https://test.api.amadeus.com/v1/security/oauth2/token')
      .to_return(status: 200, body: oauth_response.to_json, headers: rheaders)

    pricing_path = 'https://test.api.amadeus.com/v1/shopping/flight-offers/pricing'

    if include_bags
      pricing_path += '?include=bags'
    elsif include_additional_services
      pricing_path += '?include=additional_services'
    end

    stub_request(:post, pricing_path)
      .with(body: mocked_request_params.to_json)
      .to_return(status: 200,
                 body: response,
                 headers: rheaders)
  end
end

RSpec.shared_context 'post flight offer response' do
  let(:rheaders) { { "Content-Type": 'application/vnd.amadeus+json' } }
  let(:oauth_response) do
    {
      "type": 'amadeusOAuth2Token',
      "username": 'test@test.com',
      "application_name": 'volartestapp',
      "client_id": '12345',
      "token_type": 'Bearer',
      "access_token": 'token',
      "expires_in": 1799,
      "state": 'approved',
      "scope": ''
    }
  end

  before do
    response = render_custom_response('amadeus/flight_offers/get.json.erb', flight_finder_params)

    stub_request(:post, 'https://test.api.amadeus.com/v1/security/oauth2/token')
      .to_return(status: 200, body: oauth_response.to_json, headers: rheaders)

    stub_request(:post, 'https://test.api.amadeus.com/v2/shopping/flight-offers')
      .with(body: request_params.to_json)
      .to_return(status: 200,
                 body: response,
                 headers: rheaders)
  end
end

RSpec.shared_context 'post flight offer request and response no include' do
  let(:rheaders) { { "Content-Type": 'application/json' } }
  let(:oauth_response) do
    {
      "type": 'amadeusOAuth2Token',
      "username": 'test@test.com',
      "application_name": 'volartestapp',
      "client_id": '12345',
      "token_type": 'Bearer',
      "access_token": 'token',
      "expires_in": 1799,
      "state": 'approved',
      "scope": ''
    }
  end
  let(:fixed_request) { render_custom_response('amadeus/flight_pricing/requests/post_no_include.json.erb', general_parameters) }
  let(:fixed_response) { render_custom_response('amadeus/flight_pricing/responses/post_no_include.json.erb', general_parameters) }

  before do
    stub_request(:post, 'https://test.api.amadeus.com/v1/security/oauth2/token')
      .to_return(status: 200, body: oauth_response.to_json, headers: rheaders)

    pricing_path = 'https://test.api.amadeus.com/v1/shopping/flight-offers/pricing'

    if include_bags
      pricing_path += '?include=bags'
    elsif include_additional_services
      pricing_path += '?include=additional_services'
    end

    stub_request(:post, pricing_path)
      .with(body: fixed_request)
      .to_return(status: 200,
                 body: fixed_response,
                 headers: rheaders)
  end
end

RSpec.shared_context 'amadeus access token response' do
  let(:rheaders) { { "Content-Type": 'application/vnd.amadeus+json' } }
  let(:oauth_response) do
    {
      "type": 'amadeusOAuth2Token',
      "username": 'test@test.com',
      "application_name": 'volartestapp',
      "client_id": 'test',
      "token_type": 'Bearer',
      "access_token": 'token',
      "expires_in": 1799,
      "state": 'approved',
      "scope": ''
    }
  end

  before do
    stub_request(:post, 'https://test.api.amadeus.com/v1/security/oauth2/token').with(body: {
                                                                                        grant_type: 'client_credentials',
                                                                                        client_id: ENV['AMADEUS_CLIENT_ID'],
                                                                                        client_secret: ENV['AMADEUS_CLIENT_SECRET']
                                                                                      })
                                                                                .to_return(status: 200, body: oauth_response.to_json, headers: rheaders)
  end
end

RSpec.shared_context 'set countries - currencies - airport - carrier' do
  before do
    create(:country, name: 'United States', code: 'US', phone_code: '+1', language: 'English', continent: 'North America',
                     time_zone: 'UTC-4 to UTC-10')
    create(:country, name: 'European Union', code: 'EU', phone_code: '+32', language: 'English, French, German', continent: 'Europe',
                     time_zone: 'UTC-1 to UTC+3')
    create(:country, name: 'United Kingdom', code: 'GB', phone_code: '+44', language: 'English', continent: 'Europe', time_zone: 'UTC')
    create(:country, name: 'Japan', code: 'JP', phone_code: '+81', language: 'Japanese', continent: 'Asia', time_zone: 'UTC+9')
    create(:country, name: 'Australia', code: 'AU', phone_code: '+61', language: 'English', continent: 'Oceania', time_zone: 'UTC+8 to UTC+10')
    create(:country, name: 'Canada', code: 'CA', phone_code: '+1', language: 'English, French', continent: 'North America',
                     time_zone: 'UTC-3.5 to UTC-8')
    create(:country, name: 'Switzerland', code: 'CH', phone_code: '+41', language: 'German, French, Italian, Romansh', continent: 'Europe',
                     time_zone: 'UTC+1')
    create(:country, name: 'China', code: 'CN', phone_code: '+86', language: 'Mandarin', continent: 'Asia', time_zone: 'UTC+8')
    create(:country, name: 'Brazil', code: 'BR', phone_code: '+55', language: 'Portuguese', continent: 'South America', time_zone: 'UTC-2 to UTC-5')
    create(:country, name: 'Argentina', code: 'AR', phone_code: '+54', language: 'Spanish', continent: 'South America', time_zone: 'UTC-3')
    create(:country, name: 'Turkey', code: 'TR', phone_code: '+90', language: 'Turkish', continent: 'Asia', time_zone: 'UTC+3')
    create(:country, name: 'France', code: 'FR', phone_code: '+33', language: 'French', continent: 'Europe', time_zone: 'UTC+1')
    create(:country, name: 'Venezuela', code: 'VE', phone_code: '+58', language: 'Spanish', continent: 'America', time_zone: 'UTC+4')
    create(:country, name: 'Portugal', code: 'PT', phone_code: '+351', language: 'Portuguese', continent: 'Europe', time_zone: 'UTC+1')

    create(:currency, name: 'US Dollar', code: 'USD', symbol: '$', country: Country.find_by(name: 'United States'))
    create(:currency, name: 'Euro', code: 'EUR', symbol: '€', country: Country.find_by(name: 'European Union'))
    create(:currency, name: 'Pound Sterling', code: 'GBP', symbol: '£', country: Country.find_by(name: 'United Kingdom'))
    create(:currency, name: 'Japanese Yen', code: 'JPY', symbol: '¥', country: Country.find_by(name: 'Japan'))
    create(:currency, name: 'Australian Dollar', code: 'AUD', symbol: '$', country: Country.find_by(name: 'Australia'))
    create(:currency, name: 'Canadian Dollar', code: 'CAD', symbol: '$', country: Country.find_by(name: 'Canada'))
    create(:currency, name: 'Swiss Franc', code: 'CHF', symbol: 'CHF', country: Country.find_by(name: 'Switzerland'))
    create(:currency, name: 'Chinese Yuan', code: 'CNY', symbol: '¥', country: Country.find_by(name: 'China'))

    create(:airport, name: 'John F. Kennedy International Airport', city: 'New York', iata_code: 'JFK', icao_code: 'KJFK',
                     time_zone: 'America/New_York', country: Country.find_by(name: 'United States'))
    create(:airport, name: 'Los Angeles International Airport', city: 'Los Angeles', iata_code: 'LAX', icao_code: 'KLAX',
                     time_zone: 'America/Los_Angeles', country: Country.find_by(name: 'United States'))
    create(:airport, name: 'Chicago O\'Hare International Airport', city: 'Chicago', iata_code: 'ORD', icao_code: 'KORD',
                     time_zone: 'America/Chicago', country: Country.find_by(name: 'United States'))
    create(:airport, name: 'Miami International Airport', city: 'Miami', iata_code: 'MIA', icao_code: 'KMIA', time_zone: 'America/New_York',
                     country: Country.find_by(name: 'United States'))
    create(:airport, name: 'Heathrow Airport', city: 'London', iata_code: 'LHR', icao_code: 'EGLL', time_zone: 'Europe/London',
                     country: Country.find_by(name: 'United Kingdom'))
    create(:airport, name: 'Gatwick Airport', city: 'London', iata_code: 'LGW', icao_code: 'EGKK', time_zone: 'Europe/London',
                     country: Country.find_by(name: 'United Kingdom'))
    create(:airport, name: 'Charles de Gaulle Airport', city: 'Paris', iata_code: 'CDG', icao_code: 'LFPG', time_zone: 'Europe/Paris',
                     country: Country.find_by(name: 'France'))
    create(:airport, name: 'Orly Airport', city: 'Paris', iata_code: 'ORY', icao_code: 'LFPO', time_zone: 'Europe/Paris',
                     country: Country.find_by(name: 'France'))
    create(:airport, name: 'Narita International Airport', city: 'Tokyo', iata_code: 'NRT', icao_code: 'RJAA', time_zone: 'Asia/Tokyo',
                     country: Country.find_by(name: 'Japan'))
    create(:airport, name: 'Haneda Airport', city: 'Tokyo', iata_code: 'HND', icao_code: 'RJTT', time_zone: 'Asia/Tokyo',
                     country: Country.find_by(name: 'Japan'))
    create(:airport, name: 'Sydney Kingsford Smith Airport', city: 'Sydney', iata_code: 'SYD', icao_code: 'YSSY', time_zone: 'Australia/Sydney',
                     country: Country.find_by(name: 'Australia'))
    create(:airport, name: 'Melbourne Airport', city: 'Melbourne', iata_code: 'MEL', icao_code: 'YMML', time_zone: 'Australia/Melbourne',
                     country: Country.find_by(name: 'Australia'))
    create(:airport, name: 'Vancouver International Airport', city: 'Vancouver', iata_code: 'YVR', icao_code: 'CYVR', time_zone: 'America/Vancouver',
                     country: Country.find_by(name: 'Canada'))
    create(:airport, name: 'Toronto Pearson International Airport', city: 'Toronto', iata_code: 'YYZ', icao_code: 'CYYZ',
                     time_zone: 'America/Toronto', country: Country.find_by(name: 'Canada'))
    create(:airport, name: 'Zurich Airport', city: 'Zurich', iata_code: 'ZRH', icao_code: 'LSZH', time_zone: 'Europe/Zurich',
                     country: Country.find_by(name: 'Switzerland'))
    create(:airport, name: 'Geneva Airport', city: 'Geneva', iata_code: 'GVA', icao_code: 'LSGG', time_zone: 'Europe/Zurich',
                     country: Country.find_by(name: 'Switzerland'))
    create(:airport, name: 'Beijing Capital International Airport', city: 'Beijing', iata_code: 'PEK', icao_code: 'ZBAA', time_zone: 'Asia/Shanghai',
                     country: Country.find_by(name: 'China'))
    create(:airport, name: 'Ministro Pistarini International Airport', city: 'Buenos Aires', iata_code: 'EZE', icao_code: 'SAEZ',
                     time_zone: 'America/Argentina/Buenos_Aires', country: Country.find_by(name: 'Argentina'))
    create(:airport, name: 'Guarulhos International Airport', city: 'Sao Paulo', iata_code: 'GRU', icao_code: 'SBGR', time_zone: 'America/Sao_Paulo',
                     country: Country.find_by(name: 'Brazil'))
    create(:airport, name: 'Ataturk Airport', city: 'Istanbul', iata_code: 'IST', icao_code: 'LTBA', time_zone: 'Europe/Istanbul',
                     country: Country.find_by(name: 'Turkey'))
    create(:airport, name: 'Leathrow Airport', city: 'London', iata_code: 'LHR', icao_code: 'EGLL', time_zone: 'Europe/London',
                     country: Country.find_by(name: 'United Kingdom'))
    create(:airport, name: 'Caracas - Maiquetia', city: 'Caracas', iata_code: 'CCS', icao_code: 'EGLL', time_zone: 'America/Caracas',
                     country: Country.find_by(name: 'Venezuela'))
    create(:airport, name: 'Lisboa', city: 'Lisboa', iata_code: 'LIS', icao_code: 'EGLL', time_zone: 'America/Caracas',
                     country: Country.find_by(name: 'Portugal'))

    create(:carrier, name: 'American Airlines', code: 'AA')
    create(:carrier, name: 'Delta Air Lines', code: 'DL')
    create(:carrier, name: 'United Airlines', code: 'UA')
    create(:carrier, name: 'British Airways', code: 'BA')
    create(:carrier, name: 'Air France', code: 'AF')
    create(:carrier, name: 'Japan Airlines', code: 'JL')
    create(:carrier, name: 'All Nippon Airways', code: 'NH')
    create(:carrier, name: 'Qantas', code: 'QF')
    create(:carrier, name: 'Air Canada', code: 'AC')
    create(:carrier, name: 'Swiss International Air Lines', code: 'LX')
    create(:carrier, name: 'Turkish Airlines', code: 'TK')
    create(:carrier, name: 'TP Airlines', code: 'TP')
  end
end

RSpec.shared_context 'get only flight offer response' do
  let(:response) { render_custom_response('amadeus/get_flight_offer_response.json.erb', flight_finder_params) }
  let(:parsed_response) { JSON.parse(response)['data'] }
end

RSpec.shared_context 'set payment terms' do
  before do
    create(:payment_term,
           name: 'monthly',
           payment_type: 1,
           payment_terms: 'monthly',
           payment_terms_description: 'Monthly payment terms',
           payment_terms_conditions: 'Monthly payment terms conditions',
           payment_terms_conditions_url: 'https://www.example.com/monthly_payment_terms_conditions',
           payment_terms_file: 'monthly_payment_terms.pdf',
           payment_terms_file_url: 'https://www.example.com/monthly_payment_terms.pdf',
           days_max_number: 360,
           days_min_number: 30,
           payment_period_in_days: 30,
           interest_rate: 0.05,
           penalty_rate: 0.10,
           installments_max_number: 12,
           installments_min_number: 3,
           installments: true,
           active: true,
           deleted: false)

    create(:payment_term,
           name: 'weekly',
           payment_type: 1,
           payment_terms: 'weekly',
           payment_terms_description: 'Weekly payment terms',
           payment_terms_conditions: 'Weekly payment terms conditions',
           payment_terms_conditions_url: 'https://www.example.com/weekly_payment_terms_conditions',
           payment_terms_file: 'weekly_payment_terms.pdf',
           payment_terms_file_url: 'https://www.example.com/weekly_payment_terms.pdf',
           days_max_number: 84,
           days_min_number: 21,
           payment_period_in_days: 7,
           interest_rate: 0.07,
           penalty_rate: 0.10,
           installments_max_number: 12,
           installments_min_number: 3,
           installments: true,
           active: true,
           deleted: false)

    create(:payment_term,
           name: 'daily',
           payment_type: 1,
           payment_terms: 'daily',
           payment_terms_description: 'Daily payment terms',
           payment_terms_conditions: 'Daily payment terms conditions',
           payment_terms_conditions_url: 'https://www.example.com/daily_payment_terms_conditions',
           payment_terms_file: 'daily_payment_terms.pdf',
           payment_terms_file_url: 'https://www.example.com/daily_payment_terms.pdf',
           days_max_number: 31,
           days_min_number: 4,
           payment_period_in_days: 1,
           interest_rate: 0.10,
           penalty_rate: 0.10,
           installments_max_number: 30,
           installments_min_number: 3,
           installments: true,
           active: true,
           deleted: false)
  end
end

RSpec.shared_context 'set flight offers' do
  let(:flight_offers) do
    (1..3).map do
      create(:flight_offer)
    end
  end
end

RSpec.shared_context 'set flight offers in base of response' do
  include_context 'get flight offer response'

  def amadeus_client
    Amadeus::Client.new
  end

  let(:flight_search) { create(:flight_search) }
  let(:flight_offers) { FlightOffers::ResponseParser.parse(amadeus_client.get_flight_offers(request_params).data, flight_search) }
end
