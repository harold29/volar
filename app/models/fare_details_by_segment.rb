class FareDetailsBySegment < ApplicationRecord
  belongs_to :segment

  validates :cabin, presence: true
  validates :fare_basis, presence: true
  validates :branded_fare, presence: true
  validates :branded_fare_label, presence: true
  validates :flight_class, presence: true
  validates :included_checked_bags, presence: true
end
