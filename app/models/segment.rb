class Segment < ApplicationRecord
  belongs_to :itinerary
  belongs_to :carrier
  belongs_to :departure_airport, class_name: 'Airport'
  belongs_to :arrival_airport, class_name: 'Airport'
  has_many :stops, dependent: :destroy

  validates :itinerary, :carrier, presence: true
  validates :departure_at, :arrival_at, :flight_number, :duration, presence: true
  validates :stops_number, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :departure_airport, :arrival_airport, presence: true

  scope :ordered, -> { order(internal_id: :asc) }

  accepts_nested_attributes_for :stops
end
