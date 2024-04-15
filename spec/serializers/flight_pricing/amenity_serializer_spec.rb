require 'rails_helper'

RSpec.describe FlightPricing::AmenitySerializer do
  describe 'serialize' do
    let(:amenity) { create :amenity }
    let(:serialized_fields) { FlightPricing::AmenitySerializer.new(amenity).serializable_hash }

    it 'get serialized fields' do
      expect(serialized_fields[:description]).to eq(amenity.description)
      expect(serialized_fields[:is_chargeable]).to eq(amenity.is_chargeable)
      expect(serialized_fields[:amenity_type]).to eq(amenity.amenity_type)
      expect(serialized_fields[:amenity_provider]).to eq({ name: amenity.amenity_provider_name })
    end
  end
end
