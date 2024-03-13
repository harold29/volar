class CreatePrices < ActiveRecord::Migration[7.1]
  def change
    create_table :prices, id: :uuid do |t|
      t.references :flight_offer, null: false, foreign_key: true, type: :uuid
      t.decimal :price_total
      t.decimal :price_grand_total
      t.references :price_currency, foreign_key: { to_table: :currencies }, type: :uuid
      t.references :billing_currency, foreign_key: { to_table: :currencies }, type: :uuid
      t.decimal :base_fare
      t.decimal :refundable_taxes, default: 0.0

      t.timestamps
    end
  end
end
