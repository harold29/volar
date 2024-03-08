RSpec.shared_context 'get flight offer response' do
  let(:rheaders) { { "Content-Type": 'application/vnd.amadeus+json' } }
  let(:oauth_response) do
    {
      "type": 'amadeusOAuth2Token',
      "username": 'test@test.com',
      "application_name": 'volartestapp',
      "client_id": '12345',
      "token_type": 'Bearer',
      "access_token": '12345test',
      "expires_in": 1799,
      "state": 'approved',
      "scope": ''
    }
  end

  before do
    response = render_custom_response('amadeus/get_flight_offer_response.json.erb', flight_finder_params)

    stub_request(:post, 'https://test.api.amadeus.com/v1/security/oauth2/token')
      .to_return(status: 200, body: oauth_response.to_json, headers: rheaders)

    stub_request(:get, "https://test.api.amadeus.com/v2/shopping/flight-offers?adults=#{flight_finder_params[:adults]}&departureDate=#{flight_finder_params[:departure_date]}&destinationLocationCode=#{flight_finder_params[:destination]}&originLocationCode=#{flight_finder_params[:origin]}")
      .to_return(status: 200, body: response, headers: rheaders)
  end
end
