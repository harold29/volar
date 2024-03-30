require 'rails_helper'

RSpec.describe Amadeus::Errors do
  let(:response) do
    double('response',
           body: '{"error":"error","error_description":"error_description","errors":[{"source":{"parameter":"parameter"},"detail":"detail"}]}', status: 404)
  end
  let(:errors) { Amadeus::Errors.new(response) }

  it 'returns the response status code' do
    expect(errors.short_description).to eq('[404]')
  end

  it 'returns the error description' do
    expect(errors.error_description).to eq("\nerror\nerror_description")
  end

  it 'returns the errors description' do
    expect(errors.errors_description).to eq("\n[parameter] detail")
  end

  it 'returns the full description' do
    expect(errors.description).to eq("[404]\nerror\nerror_description\n[parameter] detail")
  end

  it 'returns the message' do
    expect(errors.message).to eq('error' => 'error', 'error_description' => 'error_description',
                                 'errors' => [{ 'source' => { 'parameter' => 'parameter' }, 'detail' => 'detail' }])
  end

  it 'returns the response body' do
    expect(errors.response_body).to eq('error' => 'error', 'error_description' => 'error_description',
                                       'errors' => [{ 'source' => { 'parameter' => 'parameter' }, 'detail' => 'detail' }])
  end

  it 'returns the response status code' do
    expect(errors.status_code).to eq(404)
  end

  it 'returns the response' do
    expect(errors.response).to eq(response)
  end
end
