class FlightOffer < ApplicationRecord
  belongs_to :currency

  validates :internal_id, :source, :last_ticketing_date, :number_of_bookable_seats, :price_total, presence: true
  validates :currency, presence: true
end