class CreateFareDetailsBySegments < ActiveRecord::Migration[7.1]
  def change
    create_table :fare_details_by_segments, id: :uuid do |t|
      t.belongs_to :traveler_pricing, null: false, foreign_key: true, type: :uuid
      t.string :segment_internal_id
      t.string :cabin
      t.string :fare_basis
      t.string :branded_fare
      t.string :branded_fare_label
      t.string :flight_class
      t.integer :included_checked_bags

      t.timestamps
    end
  end
end
