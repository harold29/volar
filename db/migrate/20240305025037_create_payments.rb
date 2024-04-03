class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments, id: :uuid do |t|
      t.references :flight_order, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :payment_method
      t.integer :payment_status
      t.decimal :payment_amount
      t.references :payment_currency, null: false, foreign_key: { to_table: :currencies }, type: :uuid
      t.datetime :payment_datetime
      t.datetime :confirmed_at
      t.boolean :approved
      t.boolean :declined
      t.datetime :declined_at
      t.boolean :refunded
      t.datetime :refunded_at
      t.decimal :refunded_amount
      t.references :refunded_currency, null: false, foreign_key: { to_table: :currencies }, type: :uuid
      t.string :refunded_reason
      t.references :booking, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
