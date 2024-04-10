class CreateTaxes < ActiveRecord::Migration[7.1]
  def change
    create_table :taxes, id: :uuid do |t|
      t.belongs_to :price, null: false, foreign_key: true, type: :uuid
      t.string :tax_code
      t.string :tax_description
      t.decimal :tax_amount

      t.timestamps
    end
  end
end
