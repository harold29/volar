class CreatePaymentPlans < ActiveRecord::Migration[7.1]
  def change
    create_table :payment_plans, id: :uuid do |t|
      t.date :departure_at
      t.date :return_at
      t.references :installments_currency, null: false, foreign_key: { to_table: :currencies }, type: :uuid
      t.integer :installments_number
      t.decimal :installment_amounts, array: true, precision: 10, scale: 2, default: []
      t.references :flight_offer, null: false, foreign_key: true, type: :uuid
      t.boolean :active
      t.boolean :selected

      t.timestamps
    end
  end
end
