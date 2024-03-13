class CreateCarriers < ActiveRecord::Migration[7.1]
  def change
    create_table :carriers, id: :uuid do |t|
      t.string :name
      t.string :logo
      t.string :code

      t.timestamps
    end
  end
end
