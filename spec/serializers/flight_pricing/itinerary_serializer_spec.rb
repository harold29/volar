require 'rails_helper'

RSpec.describe FlightPricing::ItinerarySerializer do
  describe 'serialize' do
    let(:itinerary) { create :itinerary }
    let(:serialized_fields) { FlightPricing::ItinerarySerializer.new(itinerary).serializable_hash }

    it 'get serialized fields' do
      expect(serialized_fields[:duration]).to eq(itinerary.duration)
      expect(serialized_fields[:segments].size).to eq(itinerary.segments.size)

      serialized_fields[:segments].each_with_index do |segment, index|
        expect(segment[:id]).to eq(itinerary.segments[index].internal_id)
        expect(segment[:number_of_stops]).to eq(itinerary.segments[index].stops_number)
        expect(segment[:duration]).to eq(itinerary.segments[index].duration)
        expect(segment[:operating][:carrier_code]).to eq(itinerary.segments[index].carrier.code)
        expect(segment[:aircraft][:code]).to eq(itinerary.segments[index].aircraft_code)
        expect(segment[:number]).to eq(itinerary.segments[index].flight_number)
        expect(segment[:carrier_code]).to eq(itinerary.segments[index].carrier.code)
        expect(segment[:arrival][:at]).to eq(itinerary.segments[index].arrival_at.strftime('%Y-%m-%dT%H:%M:%S'))
        expect(segment[:arrival][:terminal]).to eq(itinerary.segments[index].arrival_terminal)
        expect(segment[:arrival][:iata_code]).to eq(itinerary.segments[index].arrival_airport.iata_code)
        expect(segment[:departure][:at]).to eq(itinerary.segments[index].departure_at.strftime('%Y-%m-%dT%H:%M:%S'))
        expect(segment[:departure][:terminal]).to eq(itinerary.segments[index].departure_terminal)
        expect(segment[:departure][:iata_code]).to eq(itinerary.segments[index].departure_airport.iata_code)
        expect(segment[:blacklisted_in_EU]).to eq(itinerary.segments[index].blacklisted_in_eu)
      end
    end
  end
end
