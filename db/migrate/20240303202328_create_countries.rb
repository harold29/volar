class CreateCountries < ActiveRecord::Migration[7.1]
  def change
    create_table :countries, id: :uuid do |t|
      t.string :name
      t.string :code
      t.string :phone_code
      t.string :language
      t.string :continent
      t.string :time_zone

      t.timestamps
    end
  end
end
