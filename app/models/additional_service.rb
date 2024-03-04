class AdditionalService < ApplicationRecord
  belongs_to :flight_offer

  validates :flight_offer, :service_type, :service_description, :service_amount, presence: true
  validates :service_amount, numericality: true
end
