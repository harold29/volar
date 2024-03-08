class Fee < ApplicationRecord
  belongs_to :price

  validates :price, :fee_type, :fee_description, :fee_amount, presence: true
  validates :fee_amount, numericality: true
end
