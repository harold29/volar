require 'rails_helper'

RSpec.describe FareDetailsBySegment, type: :model do
  it 'is valid with valid attributes' do
    fare_details_by_segment = build(:fare_details_by_segment)
    expect(fare_details_by_segment).to be_valid
  end

  it 'is not valid without a cabin' do
    fare_details_by_segment = build(:fare_details_by_segment, cabin: nil)
    expect(fare_details_by_segment).to_not be_valid
  end

  it 'is not valid without a fare_basis' do
    fare_details_by_segment = build(:fare_details_by_segment, fare_basis: nil)
    expect(fare_details_by_segment).to_not be_valid
  end

  it 'is not valid without a branded_fare' do
    fare_details_by_segment = build(:fare_details_by_segment, branded_fare: nil)
    expect(fare_details_by_segment).to_not be_valid
  end

  it 'is not valid without a branded_fare_label' do
    fare_details_by_segment = build(:fare_details_by_segment, branded_fare_label: nil)
    expect(fare_details_by_segment).to_not be_valid
  end

  it 'is not valid without a flight_class' do
    fare_details_by_segment = build(:fare_details_by_segment, flight_class: nil)
    expect(fare_details_by_segment).to_not be_valid
  end

  it 'is not valid without a included_checked_bags' do
    fare_details_by_segment = build(:fare_details_by_segment, included_checked_bags: nil)
    expect(fare_details_by_segment).to_not be_valid
  end

  it 'is not valid without a segment_internal_id' do
    fare_details_by_segment = build(:fare_details_by_segment, segment_internal_id: nil)
    expect(fare_details_by_segment).to_not be_valid
  end
end
