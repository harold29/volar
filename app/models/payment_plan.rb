class PaymentPlan < ApplicationRecord
  before_validation :set_installments_number,
                    :set_installment_amounts,
                    :set_currency,
                    :set_last_ticketing_datetime, if: -> { :departure_at.present? && :flight_offer.present? }

  # before_validation :set_currency, on: :create, if: -> { :flight_offer.present? }

  validates :departure_at,
            :return_at,
            :installments_currency,
            :installments_number,
            :installment_amounts,
            :flight_offer,
            :payment_term,
            :last_ticketing_datetime, presence: true

  validates :active, :selected, inclusion: { in: [true, false] }

  validates :installments_number, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  belongs_to :installments_currency, class_name: 'Currency'
  belongs_to :flight_offer
  belongs_to :payment_term

  def set_installments_number
    return if departure_at.blank? || payment_term.blank?

    self.installments_number = payment_term.number_of_installments_from_date(departure_at.to_date.to_s)
  end

  def set_installment_amounts
    return if departure_at.blank? || flight_offer.blank? || payment_term.blank?

    self.installment_amounts = payment_term.calculate_installment_amounts(flight_offer.price_total,
                                                                          departure_at.to_date.to_s)
  end

  def set_currency
    return if flight_offer.blank?

    self.installments_currency = flight_offer.currency
  end

  def set_last_ticketing_datetime
    return if flight_offer.blank?

    self.last_ticketing_datetime = flight_offer.last_ticketing_datetime
  end
end
