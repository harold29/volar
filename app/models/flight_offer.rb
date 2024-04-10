class FlightOffer < ApplicationRecord
  TRAVEL_CLASSES = %w[ECONOMY PREMIUM_ECONOMY BUSINESS FIRST].freeze
  FARE_TYPES = %w[PUBLISHED NEGOTIATED CORPORATE].freeze

  belongs_to :currency
  belongs_to :flight_search

  has_many :itineraries
  has_many :segments, through: :itineraries
  has_one  :price
  has_many :taxes
  has_many :fees, through: :price
  has_many :traveler_pricings

  validates :internal_id,
            :source,
            :last_ticketing_date,
            :last_ticketing_datetime,
            :number_of_bookable_seats,
            :price_total,
            :currency, presence: true

  validates :confirmed, inclusion: { in: [true, false] }

  validates :pricing_options_fare_type, inclusion: { in: FARE_TYPES }

  scope :ordered, -> { order(internal_id: :asc) }
  scope :ordered_first, -> { order(internal_id: :asc).first }

  accepts_nested_attributes_for :itineraries, :price, :taxes, :traveler_pricings
end
