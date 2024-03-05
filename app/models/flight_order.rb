class FlightOrder < ApplicationRecord
  belongs_to :flight_offer
  belongs_to :total_price_currency, class_name: 'Currency'

  validates :order_datetime, presence: true
  validates :order_status, numericality: { only_integer: true }
  validates :total_price, numericality: true
  validates :order_id, length: { maximum: 255 }, presence: true
  validates :flight_offer, :total_price_currency, presence: true
end
