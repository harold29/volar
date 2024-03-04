class CreateAirports < ActiveRecord::Migration[7.1]
  def change
    create_table :airports, id: :uuid do |t|
      t.string :name
      t.string :city
      t.string :iata_code
      t.string :icao_code
      t.string :time_zone
      t.belongs_to :country, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
