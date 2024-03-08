class Itinerary < ApplicationRecord
  belongs_to :flight_offer

  has_many :segments, dependent: :destroy
  has_many :stops, dependent: :destroy

  validates :flight_offer, presence: true
  validates :duration, presence: true
end
