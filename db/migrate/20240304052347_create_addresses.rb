class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses, id: :uuid do |t|
      t.references :profile, null: false, foreign_key: true, type: :uuid
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :state
      t.string :postal_code
      t.references :country, null: false, foreign_key: true, type: :uuid
      t.integer :address_type, default: 0
      t.boolean :address_verified
      t.boolean :billing

      t.timestamps
    end
  end
end
