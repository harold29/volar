class CreateFlightSearches < ActiveRecord::Migration[7.1]
  def change
    create_table :flight_searches, id: :uuid do |t|
      t.references :user, null: true, foreign_key: true, type: :uuid
      t.string :origin
      t.string :destination
      t.date :departure_date
      t.date :return_date
      t.boolean :one_way, default: false
      t.integer :adults
      t.integer :children
      t.integer :infants
      t.string :travel_class
      t.decimal :max_price
      t.references :max_price_currency, null: false, foreign_key: { to_table: :currencies }, type: :uuid
      t.integer :max_stops
      t.string :max_duration
      t.string :max_duration_unit
      t.decimal :price_total
      t.decimal :price_average
      t.references :currency, null: false, foreign_key: true, type: :uuid
      t.boolean :nonstop

      t.timestamps
    end
  end
end
