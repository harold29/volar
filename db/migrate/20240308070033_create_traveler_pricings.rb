class CreateTravelerPricings < ActiveRecord::Migration[7.1]
  def change
    create_table :traveler_pricings, id: :uuid do |t|
      t.references :flight_offer, null: false, foreign_key: true, type: :uuid
      t.string :traveler_internal_id
      t.string :fare_option
      t.string :traveler_type
      t.decimal :price_total
      t.decimal :price_base
      t.references :price_currency, null: false, foreign_key: { to_table: :currencies }, type: :uuid

      t.timestamps
    end
  end
end
