class Tax < ApplicationRecord
  belongs_to :flight_offer

  validates :flight_offer, :tax_code, :tax_description, :tax_amount, presence: true

  validates :tax_amount, numericality: true
end
