class Price < ApplicationRecord
  before_validation :set_default_refundable_taxes

  belongs_to :flight_offer, required: false
  belongs_to :traveler_pricing, required: false
  belongs_to :billing_currency, class_name: 'Currency'
  belongs_to :price_currency, class_name: 'Currency'
  has_many   :fees
  has_many   :additional_services
  has_many   :taxes

  validates :price_total, :price_grand_total, :base_fare, :refundable_taxes, presence: true
  validates :billing_currency, :price_currency, presence: true

  validates :price_total, :price_grand_total, :base_fare, :refundable_taxes, numericality: true

  accepts_nested_attributes_for :fees, :additional_services, :taxes

  private

  def set_default_refundable_taxes
    self.refundable_taxes ||= 0.0
  end
end
