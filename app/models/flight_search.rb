class FlightSearch < ApplicationRecord
  belongs_to :user
  belongs_to :max_price_currency, class_name: 'Currency'

  validates :origin, :destination, :departure_date, :adults, :travel_class, presence: true

  validates :one_way, inclusion: { in: [true, false] }
  validates :adults, :children, :infants, numericality: { only_integer: true }
  validates :max_stops, numericality: { only_integer: true }
  validates :max_duration_unit, inclusion: { in: %w[hours days] }
  validates :price_total, :price_average, numericality: true, presence: true
  validates :max_price, numericality: true
  validates :max_price_currency, :user, presence: true

end
