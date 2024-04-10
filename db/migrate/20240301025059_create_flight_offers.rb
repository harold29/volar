class CreateFlightOffers < ActiveRecord::Migration[7.1]
  def change
    create_table :flight_offers, id: :uuid do |t|
      t.string :internal_id
      t.string :source
      t.boolean :instant_ticketing_required
      t.boolean :non_homogeneous
      t.boolean :one_way
      t.date :last_ticketing_date
      t.datetime :last_ticketing_datetime
      t.integer :number_of_bookable_seats
      t.decimal :price_total
      t.boolean :payment_card_required
      t.boolean :confirmed, default: false
      t.string :validating_airline_codes, array: true, default: []
      t.string :pricing_options_fare_type, array: true, default: []
      t.boolean :pricing_options_included_checked_bags_only
      t.boolean :pricing_options_refundable_fare
      t.boolean :pricing_options_no_restriction_fare
      t.boolean :pricing_options_no_penalty_fare

      t.timestamps
    end
  end
end
