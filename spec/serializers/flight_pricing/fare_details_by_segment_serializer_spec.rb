require 'rails_helper'

RSpec.describe FlightPricing::FareDetailsBySegmentSerializer do
  describe 'serialize' do
    let(:fare_details_by_segment) { create :fare_details_by_segment }
    let(:serialized_fields) { FlightPricing::FareDetailsBySegmentSerializer.new(fare_details_by_segment).serializable_hash }

    it 'get serialized fields' do
      expect(serialized_fields[:segment_id]).to eq(fare_details_by_segment.segment_internal_id)
      expect(serialized_fields[:cabin]).to eq(fare_details_by_segment.cabin)
      expect(serialized_fields[:fare_basis]).to eq(fare_details_by_segment.fare_basis)
      expect(serialized_fields[:branded_fare]).to eq(fare_details_by_segment.branded_fare)
      expect(serialized_fields[:branded_fare_label]).to eq(fare_details_by_segment.branded_fare_label)
      expect(serialized_fields[:class]).to eq(fare_details_by_segment.flight_class)
      expect(serialized_fields[:included_checked_bags][:quantity]).to eq(fare_details_by_segment.included_checked_bags)
    end

    it 'get serialized amenities' do
      expect(serialized_fields[:amenities].size).to eq(fare_details_by_segment.amenities.size)
      serialized_fields[:amenities].each_with_index do |amenity, index|
        expect(amenity[:amenity_provider][:name]).to eq(fare_details_by_segment.amenities[index].amenity_provider_name)
        expect(amenity[:amenity_type]).to eq(fare_details_by_segment.amenities[index].amenity_type)
        expect(amenity[:is_chargeable]).to eq(fare_details_by_segment.amenities[index].is_chargeable)
        expect(amenity[:description]).to eq(fare_details_by_segment.amenities[index].description)
      end
    end
  end
end
