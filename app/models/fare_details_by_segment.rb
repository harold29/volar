class FareDetailsBySegment < ApplicationRecord
  # belongs_to :segment
  belongs_to :traveler_pricing
  has_many :amenities

  validates :cabin, presence: true
  validates :fare_basis, presence: true
  validates :branded_fare, presence: true
  validates :branded_fare_label, presence: true
  validates :flight_class, presence: true
  validates :included_checked_bags, presence: true
  validates :segment_internal_id, presence: true

  accepts_nested_attributes_for :amenities
end
