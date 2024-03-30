class FlightSearch < ApplicationRecord
  before_validation :set_currencies,
                    :set_max_stops,
                    :set_price_average,
                    :set_max_price, if: -> { :flight_offers.present? }

  belongs_to :user, required: false
  belongs_to :max_price_currency, class_name: 'Currency'
  belongs_to :currency

  has_many :flight_offers

  validates :origin, :destination, :departure_date, :adults, :travel_class, presence: true

  validates :one_way, inclusion: { in: [true, false] }
  validates :adults, :children, :infants, numericality: { only_integer: true }
  validates :max_stops, numericality: { only_integer: true }
  # validates :max_duration_unit, inclusion: { in: %w[hours days] }
  validates :price_average, numericality: true, presence: true
  validates :max_price, numericality: true
  validates :max_price_currency, presence: true

  def set_currencies
    return if flight_offers.blank?

    currency = flight_offers.first.currency

    self.currency = currency
    self.max_price_currency = currency
  end

  def set_max_stops
    return if flight_offers.blank?

    self.max_stops = flight_offers.map(&:segments).flatten.map(&:stops_number).max
  end

  def set_price_average
    return if flight_offers.blank?

    self.price_average = flight_offers.map(&:price_total).sum / flight_offers.size
  end

  def set_max_price
    return if flight_offers.blank?

    self.max_price = flight_offers.map(&:price_total).max
  end
end
