class PaymentPlan < ApplicationRecord
  validates :name, :payment_type, :description, :payment_terms, :payment_terms_description,
            :payment_terms_conditions, :payment_terms_conditions_url, :payment_terms_conditions_file,
            :payment_terms_conditions_file_url, presence: true
end
