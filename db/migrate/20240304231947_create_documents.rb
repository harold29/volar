class CreateDocuments < ActiveRecord::Migration[7.1]
  def change
    create_table :documents, id: :uuid do |t|
      t.integer :document_type, default: 0, null: false
      t.string :document_number
      t.date :expiration_date
      t.references :issuance_country, null: false, foreign_key: { to_table: :countries }, type: :uuid
      t.references :nationality, null: false, foreign_key: { to_table: :countries }, type: :uuid

      t.timestamps
    end
  end
end
