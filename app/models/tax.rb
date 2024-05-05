class Tax < ApplicationRecord
  belongs_to :price

  validates :tax_code, :tax_amount, presence: true

  validates :tax_amount, numericality: true
end
