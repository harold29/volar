class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings, id: :uuid do |t|
      t.datetime :booking_datetime
      t.integer :booking_status, default: 0
      t.decimal :booking_amount
      t.references :booking_currency, null: false, foreign_key: { to_table: :currencies }, type: :uuid
      t.boolean :booking_confirmed, default: false
      t.datetime :booking_confirmation_datetime
      t.string :booking_confirmation_number
      t.string :payment_type
      t.references :payment_plan, null: false, foreign_key: true, type: :uuid
      t.integer :total_installments
      t.decimal :installments_amount
      t.integer :payments_completed

      t.timestamps
    end
  end
end
