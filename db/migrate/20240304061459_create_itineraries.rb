class CreateItineraries < ActiveRecord::Migration[7.1]
  def change
    create_table :itineraries, id: :uuid do |t|
      t.references :flight_offer, null: false, foreign_key: true, type: :uuid
      t.string :duration

      t.timestamps
    end
  end
end
