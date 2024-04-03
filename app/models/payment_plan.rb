class PaymentPlan < ApplicationRecord
  before_validation :set_installments_number,
                    :set_installments_amounts,
                    :set_amount_due,
                    :set_currency,
                    :set_last_ticketing_datetime, if: -> { :departure_at.present? && :flight_offer.present? }

  # before_validation :set_currency, on: :create, if: -> { :flight_offer.present? }

  validates :departure_at,
            :return_at,
            :installments_currency,
            :installments_number,
            :installments_amounts,
            :flight_offer,
            :payment_term,
            :last_ticketing_datetime, presence: true

  validates :active, :selected, inclusion: { in: [true, false] }

  validates :installments_number, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  enum payment_plan_status: %i[initial in_progress completed failed cancelled]

  belongs_to :installments_currency, class_name: 'Currency'
  belongs_to :flight_offer
  belongs_to :payment_term

  def set_installments_number
    return if departure_at.blank? || payment_term.blank?

    self.installments_number = payment_term.number_of_installments_from_date(departure_at.to_date.to_s)
  end

  def set_installments_amounts
    return if departure_at.blank? || flight_offer.blank? || payment_term.blank?

    self.installments_amounts = payment_term.calculate_installments_amounts(flight_offer.price_total,
                                                                          departure_at.to_date.to_s)
  end

  def set_amount_due
    return if flight_offer.blank?

    self.amount_due = flight_offer.price_total
  end

  def set_currency
    return if flight_offer.blank?

    self.installments_currency = flight_offer.currency
  end

  def set_last_ticketing_datetime
    return if flight_offer.blank?

    self.last_ticketing_datetime = flight_offer.last_ticketing_datetime
  end

  def complete!
    self.completed_at = Time.now
    self.payment_plan_status = :completed
    self.save
  end

  def fail!
    self.failed_at = Time.now
    self.payment_plan_status = :failed
    self.save
  end

  def cancel!
    self.cancelled_at = Time.now
    self.payment_plan_status = :cancelled
    self.save
  end
end
