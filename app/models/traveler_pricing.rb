class TravelerPricing < ApplicationRecord
  belongs_to :flight_offer
  belongs_to :traveler
  belongs_to :price_currency, class_name: 'Currency'

  validates :fare_option, :traveler_type, :price_total, :flight_offer_internal_id, presence: true
  validates :price_total, numericality: true
end
