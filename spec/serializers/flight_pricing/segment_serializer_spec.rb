require 'rails_helper'

RSpec.describe FlightPricing::SegmentSerializer do
  describe 'serialize' do
    let(:segment) { create :segment }
    let(:serialized_fields) do
      ActiveModelSerializers::SerializableResource.new(segment,
                                                       { serializer: FlightPricing::SegmentSerializer,
                                                         include: '**' }).serializable_hash
    end

    it 'get serialized fields' do
      expect(serialized_fields[:departure][:iata_code]).to eq(segment.departure_airport.iata_code)
      expect(serialized_fields[:departure][:terminal]).to eq(segment.departure_terminal)
      expect(serialized_fields[:departure][:at]).to eq(segment.departure_at.strftime('%Y-%m-%dT%H:%M:%S'))

      expect(serialized_fields[:arrival][:iata_code]).to eq(segment.arrival_airport.iata_code)
      expect(serialized_fields[:arrival][:terminal]).to eq(segment.arrival_terminal)
      expect(serialized_fields[:arrival][:at]).to eq(segment.arrival_at.strftime('%Y-%m-%dT%H:%M:%S'))

      expect(serialized_fields[:carrier_code]).to eq(segment.carrier.code)
      expect(serialized_fields[:number]).to eq(segment.flight_number)
      expect(serialized_fields[:aircraft][:code]).to eq(segment.aircraft_code)
      expect(serialized_fields[:operating][:carrier_code]).to eq(segment.carrier.code)
      expect(serialized_fields[:duration]).to eq(segment.duration)
      expect(serialized_fields[:number_of_stops]).to eq(segment.stops_number)
      expect(serialized_fields[:id]).to eq(segment.internal_id)
      expect(serialized_fields[:blacklisted_in_EU]).to eq(segment.blacklisted_in_eu)
    end

    it 'get serialized stops' do
      expect(serialized_fields[:stops].size).to eq(segment.stops.size)
      serialized_fields[:stops].each_with_index do |stop, index|
        expect(stop[:iata_code]).to eq(segment.stops[index].airport.iata_code)
        expect(stop[:duration]).to eq(segment.stops[index].duration)
        expect(stop[:arrival_at]).to eq(segment.stops[index].arrival_at.strftime('%Y-%m-%dT%H:%M:%S'))
        expect(stop[:departure_at]).to eq(segment.stops[index].departure_at.strftime('%Y-%m-%dT%H:%M:%S'))
      end
    end
  end
end
