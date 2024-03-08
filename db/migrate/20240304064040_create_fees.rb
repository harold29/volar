class CreateFees < ActiveRecord::Migration[7.1]
  def change
    create_table :fees, id: :uuid do |t|
      t.references :price, null: false, foreign_key: true, type: :uuid
      t.string :fee_type
      t.string :fee_description
      t.decimal :fee_amount

      t.timestamps
    end
  end
end
