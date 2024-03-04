class Fee < ApplicationRecord
  belongs_to :flight_offer

  validates :flight_offer, :fee_type, :fee_description, :fee_amount, presence: true
  validates :fee_amount, numericality: true
end
