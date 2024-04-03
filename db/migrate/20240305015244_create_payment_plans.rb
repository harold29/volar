class CreatePaymentPlans < ActiveRecord::Migration[7.1]
  def change
    create_table :payment_plans, id: :uuid do |t|
      t.date :departure_at
      t.date :return_at
      t.references :installments_currency, null: false, foreign_key: { to_table: :currencies }, type: :uuid
      t.integer :installments_number
      t.decimal :installments_amounts, array: true, precision: 10, scale: 2, default: []
      t.decimal :amount_due, default: 0.0
      t.datetime :last_ticketing_datetime
      t.references :flight_offer, null: false, foreign_key: true, type: :uuid
      t.boolean :active, default: false
      t.boolean :selected, default: false
      t.integer :payment_plan_status, default: 0
      t.datetime :completed_at
      t.datetime :failed_at
      t.datetime :cancelled_at

      t.timestamps
    end
  end
end
