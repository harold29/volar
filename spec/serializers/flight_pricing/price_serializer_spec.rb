require 'rails_helper'

RSpec.describe FlightPricing::PriceSerializer do
  describe 'serialize' do
    let(:price) { create :price }
    let(:serialized_fields) { FlightPricing::PriceSerializer.new(price).serializable_hash }

    it 'get serialized fields' do
      expect(serialized_fields[:currency]).to eq(price.price_currency.code)
      expect(serialized_fields[:total]).to eq(price.price_total)
      expect(serialized_fields[:base]).to eq(price.base_fare)
      expect(serialized_fields[:grand_total]).to eq(price.price_grand_total)

      expect(serialized_fields[:fees].size).to eq(price.fees.size)

      serialized_fields[:fees].each_with_index do |fee, index|
        expect(fee[:amount]).to eq(price.fees[index].fee_amount)
        expect(fee[:type]).to eq(price.fees[index].fee_type)
      end
    end
  end
end
