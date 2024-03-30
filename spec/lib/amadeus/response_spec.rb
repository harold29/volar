require 'rails_helper'

RSpec.describe Amadeus::Response do
  let(:response) do
    double('response',
           body: '{"data": {"flights": []}, "meta": {"count": 0}}', status: 200)
  end
  let(:amadeus_response) { Amadeus::Response.new(response) }

  it 'returns the data' do
    expect(amadeus_response.data).to eq('flights' => [])
  end

  it 'returns the meta' do
    expect(amadeus_response.meta).to eq('count' => 0)
  end

  it 'returns the status' do
    expect(amadeus_response.status).to eq(200)
  end

  it 'returns the json response' do
    expect(amadeus_response.json_response).to eq('{"data": {"flights": []}, "meta": {"count": 0}}')
  end

  it 'returns the response' do
    expect(amadeus_response.response).to eq(response)
  end
end
