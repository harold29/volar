class Itinerary < ApplicationRecord
  belongs_to :flight_offer

  has_many :segments, -> { order(internal_id: :asc) }, dependent: :destroy
  has_many :stops, through: :segment, dependent: :destroy

  validates :flight_offer, presence: true
  validates :duration, presence: true

  scope :ordered_by_flight_offer_internal_id, lambda {
    joins(:flight_offer).order('flight_offers.internal_id ASC')
  }

  accepts_nested_attributes_for :segments
end
