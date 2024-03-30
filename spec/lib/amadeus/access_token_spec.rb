require 'rails_helper'

RSpec.describe Amadeus::AccessToken do
  include_context 'amadeus access token response'

  let(:access_token) { Amadeus::AccessToken.instance }

  it 'returns the bearer token' do
    expect(access_token.bearer_token).to eq('token')
  end

  it 'returns the access token' do
    expect(access_token.send(:token)).to eq('token')
  end

  it 'updates the access token' do
    access_token.send(:update_access_token)
    expect(access_token.bearer_token).to eq('token')
  end

  it 'checks if the token needs to be refreshed' do
    # Token is recently refreshed. It does not need to be refreshed.
    expect(access_token.send(:needs_refresh?)).to eq(false)
  end

  it 'stores the access token' do
    access_token_response = { 'access_token' => 'new_token', 'expires_in' => 100 }

    access_token.send(:store_access_token, access_token_response)
    expect(access_token.bearer_token).to eq('new_token')
  end
end
