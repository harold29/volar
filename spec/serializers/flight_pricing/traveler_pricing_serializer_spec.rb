require 'rails_helper'

RSpec.describe FlightPricing::TravelerPricingSerializer do
  describe 'serialize' do
    let(:traveler_pricing) { create :traveler_pricing }
    let(:serialized_fields) do
      ActiveModelSerializers::SerializableResource.new(traveler_pricing,
                                                       { serializer: FlightPricing::TravelerPricingSerializer,
                                                         include: '**' }).serializable_hash
    end
    it 'get serialized fields' do
      expect(serialized_fields[:traveler_id]).to eq(traveler_pricing.traveler_internal_id)
      expect(serialized_fields[:fare_option]).to eq(traveler_pricing.fare_option)
      expect(serialized_fields[:traveler_type]).to eq(traveler_pricing.traveler_type)

      expect(serialized_fields[:fare_details_by_segments].size).to eq(traveler_pricing.fare_details_by_segments.size)

      serialized_fields[:fare_details_by_segments].each_with_index do |fare_detail, index|
        expect(fare_detail[:segment_id]).to eq(traveler_pricing.fare_details_by_segments[index].segment_internal_id)
      end
    end
  end
end
