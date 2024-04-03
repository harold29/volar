class Booking < ApplicationRecord
  before_validation :set_installments_info


  has_one :flight_order
  belongs_to :booking_currency, class_name: 'Currency'
  belongs_to :payment_plan
  has_many :payments

  validates :booking_confirmed, inclusion: { in: [true, false] }
  validates :payment_plan, :booking_status, presence: true
  validates :total_installments, :installments_paid, numericality: { only_integer: true }
  validates :booking_amount_due, numericality: true
  validates :booking_confirmation_number, :payment_type, length: { maximum: 255 }

  enum booking_status: %i[open price_confirmed in_progress completed cancelled]

  def set_booking_datetime
    self.booking_datetime = Time.now
  end

  def set_installments_info
    return if self.payment_plan.blank?

    self.booking_amount_due = self.payment_plan.amount_due
    self.booking_currency = self.payment_plan.installments_currency
    self.total_installments = self.payment_plan.installments_number
    self.installments_number = self.payment_plan.installments_number
    self.installments_amounts = self.payment_plan.installments_amounts
  end

  def flight_offer
    self.payment_plan.flight_offer
  end

  def confirm_price!
    self.price_confirmed_at = Time.now
    self.booking_status = :price_confirmed
    self.save
  end

  def complete!
    self.completed_at = Time.now
    self.booking_status = :completed
    self.save
  end

  def cancel!
    self.cancelled_at = Time.now
    self.booking_status = :cancelled
    self.save
  end
end
