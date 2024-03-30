require 'rails_helper'

RSpec.describe Amadeus::RequestParamsSerializer do
  let(:currency) { create(:currency, code: 'USD') }
  let(:input_hash) { { currency_id: currency.id, one_way: true, origin: 'ORI', destination: 'DES' } }

  it 'serializes the input hash' do
    expect(described_class.serialize(input_hash)).to eq({ 'currencyCode' => 'USD',
                                                          'destinationLocationCode' => 'DES', 'originLocationCode' => 'ORI' })
  end

  it 'returns nil for not allowed fields' do
    expect(described_class.serialize(input_hash)).not_to have_key('oneWay')
  end

  it 'returns the currency code' do
    expect(described_class.get_currency_code('USD')).to eq('USD')
  end

  it 'returns the currency code for a currency object' do
    expect(described_class.get_currency_code(currency)).to eq('USD')
  end

  it 'returns the camelized string' do
    expect(described_class.camelize('currency_id')).to eq('currencyId')
  end

  it 'returns the camelized string for multiple words' do
    expect(described_class.camelize('departure_date')).to eq('departureDate')
  end

  it 'returns the camelized string for a single word' do
    expect(described_class.camelize('origin')).to eq('origin')
  end
end
