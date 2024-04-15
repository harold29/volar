require 'rails_helper'

RSpec.describe FlightPricing::FlightOfferSerializer do
  describe 'serialize' do
    let(:flight_offer) { create :flight_offer }
    let(:serialized_fields) do
      ActiveModelSerializers::SerializableResource.new(flight_offer,
                                                       { serializer: FlightPricing::FlightOfferSerializer,
                                                         include: '**' }).serializable_hash
    end

    it 'get serialized fields' do
      expect(serialized_fields[:id]).to eq(flight_offer.internal_id)
      expect(serialized_fields[:price][:currency]).to eq(flight_offer.price.price_currency.code)
      expect(serialized_fields[:price][:total]).to eq(flight_offer.price.price_total)
      expect(serialized_fields[:price][:base]).to eq(flight_offer.price.base_fare)
      expect(serialized_fields[:price][:fees].size).to eq(flight_offer.price.fees.size)
      expect(serialized_fields[:price][:grand_total]).to eq(flight_offer.price.price_grand_total)

      expect(serialized_fields[:pricing_options][:fare_type]).to eq(flight_offer.pricing_options_fare_type)
      expect(serialized_fields[:pricing_options][:included_checked_bags_only]).to eq(flight_offer.pricing_options_included_checked_bags_only)
      expect(serialized_fields[:pricing_options][:refundable_fare]).to eq(flight_offer.pricing_options_refundable_fare)
      expect(serialized_fields[:pricing_options][:no_restriction_fare]).to eq(flight_offer.pricing_options_no_restriction_fare)
      expect(serialized_fields[:pricing_options][:no_penalty_fare]).to eq(flight_offer.pricing_options_no_penalty_fare)

      serialized_fields[:itineraries].each_with_index do |itineraries, index|
        expect(itineraries[:duration]).to eq(flight_offer.itineraries[index].duration)

        itineraries[:segments].each_with_index do |segment, sindex|
          expect(segment[:id]).to eq(flight_offer.itineraries[index].segments[sindex].internal_id)
          expect(segment[:number_of_stops]).to eq(flight_offer.itineraries[index].segments[sindex].stops_number)
          expect(segment[:duration]).to eq(flight_offer.itineraries[index].segments[sindex].duration)
          expect(segment[:operating][:carrier_code]).to eq(flight_offer.itineraries[index].segments[sindex].carrier.code)
          expect(segment[:aircraft][:code]).to eq(flight_offer.itineraries[index].segments[sindex].aircraft_code)
          expect(segment[:number]).to eq(flight_offer.itineraries[index].segments[sindex].flight_number)
          expect(segment[:carrier_code]).to eq(flight_offer.itineraries[index].segments[sindex].carrier.code)
          expect(segment[:arrival][:at]).to eq(flight_offer.itineraries[index].segments[sindex].arrival_at.strftime('%Y-%m-%dT%H:%M:%S'))
          expect(segment[:arrival][:terminal]).to eq(flight_offer.itineraries[index].segments[sindex].arrival_terminal)
          expect(segment[:arrival][:iata_code]).to eq(flight_offer.itineraries[index].segments[sindex].arrival_airport.iata_code)
          expect(segment[:departure][:at]).to eq(flight_offer.itineraries[index].segments[sindex].departure_at.strftime('%Y-%m-%dT%H:%M:%S'))
          expect(segment[:departure][:terminal]).to eq(flight_offer.itineraries[index].segments[sindex].departure_terminal)
          expect(segment[:departure][:iata_code]).to eq(flight_offer.itineraries[index].segments[sindex].departure_airport.iata_code)
          expect(segment[:blacklisted_in_EU]).to eq(flight_offer.itineraries[index].segments[sindex].blacklisted_in_eu)
        end
      end
    end

    it 'get serialized fields with depth 1' do
      expect(serialized_fields[:itineraries].size).to eq(flight_offer.itineraries.size)
      expect(serialized_fields[:traveler_pricings].size).to eq(flight_offer.traveler_pricings.size)
    end

    it 'get serialized fields with depth 2' do
      serialized_fields[:itineraries].each_with_index do |itineraries, index|
        expect(itineraries[:segments].size).to eq(flight_offer.itineraries[index].segments.size)
      end

      serialized_fields[:traveler_pricings].each_with_index do |traveler_pricings, index|
        expect(traveler_pricings[:fare_details_by_segments].size).to eq(flight_offer.traveler_pricings[index].fare_details_by_segments.size)
      end
    end

    it 'get serialized fields with depth 3' do
      serialized_fields[:traveler_pricings].each_with_index do |traveler_pricings, index|
        expect(traveler_pricings[:fare_details_by_segments].size).to eq(flight_offer.traveler_pricings[index].fare_details_by_segments.size)
        traveler_pricings[:fare_details_by_segments][index][:amenities].each_with_index do |amenity, aindex|
          expect(amenity[:description]).to eq(flight_offer.traveler_pricings[index].fare_details_by_segments[index].amenities[aindex].description)
          expect(amenity[:is_chargeable]).to eq(flight_offer.traveler_pricings[index].fare_details_by_segments[index].amenities[aindex].is_chargeable)
        end
      end
    end
  end
end
