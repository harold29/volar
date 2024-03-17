class PaymentPlan < ApplicationRecord
  validates :departure_at,
            :return_at,
            :installments_currency,
            :installments_number,
            :installment_amounts,
            :flight_offer,
            :payment_term, presence: true

  validates :active, :selected, inclusion: { in: [true, false] }

  validates :installments_number, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  belongs_to :installments_currency, class_name: 'Currency'
  belongs_to :flight_offer
  belongs_to :payment_term
end
