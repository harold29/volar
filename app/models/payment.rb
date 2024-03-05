class Payment < ApplicationRecord
  belongs_to :flight_order
  belongs_to :user
  belongs_to :payment_currency, class_name: 'Currency'
  belongs_to :refunded_currency, class_name: 'Currency'
  belongs_to :booking

  validates :payment_method, length: { maximum: 255 }, presence: true
  validates :payment_status, numericality: { only_integer: true }
  validates :payment_amount, numericality: true
  validates :payment_currency, :booking, :flight_order, :user, presence: true
  validates :payment_datetime, presence: true
  validates :refunded_reason, length: { maximum: 255 }
  validates :refunded_amount, numericality: true
end
