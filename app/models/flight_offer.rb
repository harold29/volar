class FlightOffer < ApplicationRecord
  belongs_to :currency
  has_many :itineraries
  has_many :segments, through: :itineraries
  has_one  :price
  has_many :taxes
  has_many :fees, through: :price
  has_many :additional_services

  validates :internal_id, :source, :last_ticketing_date, :number_of_bookable_seats, :price_total, presence: true
  validates :currency, presence: true
end
