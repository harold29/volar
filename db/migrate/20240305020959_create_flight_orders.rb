class CreateFlightOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :flight_orders, id: :uuid do |t|
      t.references :flight_offer, null: false, foreign_key: true, type: :uuid
      # t.references :payment, null: false, foreign_key: true, type: :uuid
      t.string :order_id
      t.datetime :order_datetime
      t.integer :order_status
      t.decimal :total_price
      t.references :total_price_currency, null: false, foreign_key: { to_table: :currencies }, type: :uuid

      t.timestamps
    end
  end
end
