class FlightOffer < ApplicationRecord
  belongs_to :currency
  belongs_to :flight_search

  has_many :itineraries
  has_many :segments, through: :itineraries
  has_one  :price
  has_many :taxes
  has_many :fees, through: :price
  has_many :additional_services
  has_many :traveler_pricings
  has_many :payment_plans

  validates :internal_id,
            :source,
            :last_ticketing_date,
            :last_ticketing_datetime,
            :number_of_bookable_seats,
            :price_total, presence: true
  validates :currency, presence: true

  scope :ordered, -> { order(internal_id: :asc) }
  scope :ordered_first, -> { order(internal_id: :asc).first }

  accepts_nested_attributes_for :itineraries, :price, :taxes, :traveler_pricings
end
