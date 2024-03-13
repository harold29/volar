class TravelerPricing < ApplicationRecord
  belongs_to :flight_offer
  belongs_to :price_currency, class_name: 'Currency'
  has_many :fare_details_by_segments

  validates :fare_option, :traveler_type, :price_total, :traveler_internal_id, presence: true
  validates :price_total, :price_base, numericality: true

  accepts_nested_attributes_for :fare_details_by_segments
end
