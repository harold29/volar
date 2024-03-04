class CreateTaxes < ActiveRecord::Migration[7.1]
  def change
    create_table :taxes, id: :uuid do |t|
      t.references :flight_offer, null: false, foreign_key: true, type: :uuid
      t.string :tax_code
      t.string :tax_description
      t.decimal :tax_amount

      t.timestamps
    end
  end
end
