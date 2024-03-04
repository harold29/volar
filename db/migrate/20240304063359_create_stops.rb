class CreateStops < ActiveRecord::Migration[7.1]
  def change
    create_table :stops, id: :uuid do |t|
      t.references :segment, null: false, foreign_key: true, type: :uuid
      t.references :airport, null: false, foreign_key: true, type: :uuid
      t.string :duration
      t.datetime :arrival_at
      t.datetime :departure_at

      t.timestamps
    end
  end
end
