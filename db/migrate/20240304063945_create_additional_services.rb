class CreateAdditionalServices < ActiveRecord::Migration[7.1]
  def change
    create_table :additional_services, id: :uuid do |t|
      t.references :flight_offer, null: false, foreign_key: true, type: :uuid
      t.string :service_type
      t.string :service_description
      t.decimal :service_amount

      t.timestamps
    end
  end
end
