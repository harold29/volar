# frozen_string_literal: true

class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles, id: :uuid do |t|
      t.string :first_name
      t.string :last_name
      # t.string :email
      t.string :phone_number_1
      t.string :phone_number_2
      t.string :gender
      t.boolean :available
      t.boolean :deleted
      t.datetime :birthdate
      t.belongs_to :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
