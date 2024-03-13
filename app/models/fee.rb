class Fee < ApplicationRecord
  before_validation :set_default_fee_description

  belongs_to :price

  validates :price, :fee_type, :fee_description, :fee_amount, presence: true
  validates :fee_amount, numericality: true

  def set_default_fee_description
    self.fee_description ||= 'Default Description'
  end
end
