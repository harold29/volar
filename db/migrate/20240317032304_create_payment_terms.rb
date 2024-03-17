class CreatePaymentTerms < ActiveRecord::Migration[7.1]
  def change
    create_table :payment_terms, id: :uuid do |t|
      t.string :name
      t.text :description
      t.integer :payment_type
      t.string :payment_terms
      t.text :payment_terms_description
      t.string :payment_terms_conditions
      t.string :payment_terms_conditions_url
      t.string :payment_terms_file
      t.string :payment_terms_file_url
      t.integer :days_max_number
      t.integer :days_min_number
      t.integer :payment_period_in_days
      t.decimal :interest_rate
      t.decimal :penalty_rate
      t.integer :installments_max_number
      t.integer :installments_min_number
      t.boolean :installments
      t.boolean :active
      t.boolean :deleted

      t.timestamps
    end
  end
end
