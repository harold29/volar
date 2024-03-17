class PaymentTermSerializer < ApplicationSerializer
  attributes :id, :name, :description, :payment_terms, :payment_terms_description, :payment_terms_conditions, :payment_terms_conditions_url, :payment_terms_file, :payment_terms_conditions_file_url, :days_max_number, :days_min_number, :payment_period_in_days, :interest_rate, :penalty_rate, :installments_max_number, :installments_min_number, :active, :deleted
end
