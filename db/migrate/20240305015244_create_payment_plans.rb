class CreatePaymentPlans < ActiveRecord::Migration[7.1]
  def change
    create_table :payment_plans, id: :uuid do |t|
      t.string :name
      t.string :payment_type
      t.string :description
      t.string :payment_terms
      t.string :payment_terms_description
      t.string :payment_terms_conditions
      t.string :payment_terms_conditions_url
      t.string :payment_terms_conditions_file
      t.string :payment_terms_conditions_file_url

      t.timestamps
    end
  end
end
