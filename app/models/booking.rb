class Booking < ApplicationRecord
  belongs_to :flight_order
  belongs_to :booking_currency, class_name: 'Currency'
  belongs_to :payment_plan

  validates :booking_datetime, presence: true
  validates :booking_confirmed, inclusion: { in: [true, false] }
  validates :booking_confirmation_datetime, :booking_confirmation_number, :payment_type, presence: true
  validates :booking_status, :total_installments, :payments_completed, numericality: { only_integer: true }
  validates :booking_amount, :installments_amount, numericality: true
  validates :booking_confirmation_number, :payment_type, length: { maximum: 255 }


  enum booking_status: { pending: 0, confirmed: 1, in_progress: 3, completed: 4, cancelled: 5 }
end
