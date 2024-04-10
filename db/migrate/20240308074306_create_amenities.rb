class CreateAmenities < ActiveRecord::Migration[7.1]
  def change
    create_table :amenities, id: :uuid do |t|
      t.references :fare_details_by_segment, null: false, foreign_key: true, type: :uuid
      t.string :description
      t.boolean :is_chargeable
      t.string :amenity_type
      t.string :amenity_provider_name
      t.boolean :selected_by_customer, default: false

      t.timestamps
    end
  end
end
