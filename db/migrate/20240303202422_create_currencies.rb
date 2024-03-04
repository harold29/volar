class CreateCurrencies < ActiveRecord::Migration[7.1]
  def change
    create_table :currencies, id: :uuid do |t|
      t.string :name
      t.string :symbol
      t.string :code
      t.belongs_to :country, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
