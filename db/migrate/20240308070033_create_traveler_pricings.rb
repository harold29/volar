class CreateTravelerPricings < ActiveRecord::Migration[7.1]
  def change
    create_table :traveler_pricings, id: :uuid do |t|
      t.references :flight_offer, null: false, foreign_key: true, type: :uuid
      t.references :traveler, null: false, foreign_key: true, type: :uuid
      t.string :flight_offer_internal_id
      t.string :fare_option
      t.string :traveler_type
      t.decimal :price_total
      t.references :price_currency, null: false, foreign_key: { to_table: :currencies }, type: :uuid

      t.timestamps
    end
  end
end
