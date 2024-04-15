require 'rails_helper'

RSpec.describe FlightPricing::StopSerializer do
  describe 'serialize' do
    let(:stop) { create :stop }
    let(:serialized_fields) { FlightPricing::StopSerializer.new(stop).serializable_hash }

    it 'get serialized fields' do
      expect(serialized_fields[:iata_code]).to eq(stop.airport.iata_code)
      expect(serialized_fields[:duration]).to eq(stop.duration)
      expect(serialized_fields[:arrival_at]).to eq(stop.arrival_at.strftime('%Y-%m-%dT%H:%M:%S'))
      expect(serialized_fields[:departure_at]).to eq(stop.departure_at.strftime('%Y-%m-%dT%H:%M:%S'))
    end

    it 'get serialized fields with nil values' do
      stop.update(departure_at: nil, arrival_at: nil)
      serialized_fields = FlightPricing::StopSerializer.new(stop).serializable_hash

      expect(serialized_fields[:departure_at]).to eq(nil)
      expect(serialized_fields[:arrival_at]).to eq(nil)
    end

    it 'get serialized fields with nil airport' do
      stop.update(airport: nil)
      serialized_fields = FlightPricing::StopSerializer.new(stop).serializable_hash

      expect(serialized_fields[:iata_code]).to eq(nil)
    end
  end
end
