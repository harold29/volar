class CreateSegments < ActiveRecord::Migration[7.1]
  def change
    create_table :segments, id: :uuid do |t|
      t.references :itinerary, null: false, foreign_key: true, type: :uuid
      t.references :departure_airport, null: false, foreign_key: { to_table: :airports }, type: :uuid
      t.references :arrival_airport, null: false, foreign_key: { to_table: :airports }, type: :uuid
      t.datetime :departure_at
      t.datetime :arrival_at
      t.references :carrier, null: false, foreign_key: true, type: :uuid
      t.string :flight_number
      t.string :aircraft_code
      t.string :duration
      t.integer :stops_number
      t.boolean :blacklisted_in_eu

      t.timestamps
    end
  end
end
