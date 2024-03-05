class CreateTravelers < ActiveRecord::Migration[7.1]
  def change
    create_table :travelers, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :traveler_type, default: 0
      t.date :birthdate
      t.references :document, null: false, foreign_key: true, type: :uuid
      t.references :telephone, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
