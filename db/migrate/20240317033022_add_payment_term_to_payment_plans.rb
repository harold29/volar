class AddPaymentTermToPaymentPlans < ActiveRecord::Migration[7.1]
  def change
    add_reference :payment_plans, :payment_term, foreign_key: true, type: :uuid
  end
end
