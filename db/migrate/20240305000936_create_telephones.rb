class CreateTelephones < ActiveRecord::Migration[7.1]
  def change
    create_table :telephones, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :area_code
      t.string :phone_number
      t.integer :phone_type
      t.boolean :phone_verified

      t.timestamps
    end
  end
end
