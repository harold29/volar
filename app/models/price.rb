class Price < ApplicationRecord
  belongs_to :flight_offer
  belongs_to :billing_currency, class_name: 'Currency'
  belongs_to :price_currency, class_name: 'Currency'
  has_many   :fees

  validates :price_total, :price_grand_total, :base_fare, :refundable_taxes, presence: true
  validates :billing_currency, :price_currency, :flight_offer, presence: true

  validates :price_total, :price_grand_total, :base_fare, :refundable_taxes, numericality: true
end
