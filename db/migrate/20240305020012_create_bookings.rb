class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings, id: :uuid do |t|
      t.datetime :booking_datetime
      t.integer :booking_status, default: 0
      t.decimal :booking_amount_due, default: 0.0
      t.references :booking_currency, null: false, foreign_key: { to_table: :currencies }, type: :uuid
      t.boolean :booking_confirmed, default: false
      t.datetime :booking_confirmation_datetime
      t.string :booking_confirmation_number
      t.string :payment_type
      t.references :payment_plan, null: false, foreign_key: true, type: :uuid
      t.integer :total_installments, default: 0
      t.decimal :installments_amounts, array: true, precision: 10, scale: 2, default: []
      t.integer :installments_number, default: 0
      t.integer :installments_paid, default: 0
      t.datetime :price_confirmed_at
      t.datetime :completed_at
      t.datetime :cancelled_at

      t.timestamps
    end
  end
end
