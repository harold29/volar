class FlightOffer < ApplicationRecord
  belongs_to :currency

  validates :internal_id, presence: true
  validates :source, presence: true
  validates :last_ticketing_date, presence: true
  validates :number_of_bookable_seats, presence: true
  validates :price_total, presence: true
  validates :currency, presence: true
end
