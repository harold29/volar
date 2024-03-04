class CreateFlightOffers < ActiveRecord::Migration[7.1]
  def change
    create_table :flight_offers, id: :uuid do |t|
      t.string :internal_id
      t.string :source
      t.boolean :instant_ticketing_required
      t.boolean :non_homogeneous
      t.boolean :one_way
      t.date :last_ticketing_date
      t.integer :number_of_bookable_seats
      t.decimal :price_total
      t.boolean :payment_card_required

      t.timestamps
    end
  end
end
