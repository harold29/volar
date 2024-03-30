class AdditionalService < ApplicationRecord
  belongs_to :price

  validates :price, :service_type, :service_amount, presence: true
  validates :service_amount, numericality: true
end
