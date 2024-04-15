require 'rails_helper'

RSpec.describe FlightPricing::FeeSerializer do
  describe 'serialize' do
    let(:fee) { create :fee }
    let(:serialized_fields) { FlightPricing::FeeSerializer.new(fee).serializable_hash }

    it 'get serialized fields' do
      expect(serialized_fields[:amount]).to eq(fee.fee_amount)
      expect(serialized_fields[:type]).to eq(fee.fee_type)
    end
  end
end
