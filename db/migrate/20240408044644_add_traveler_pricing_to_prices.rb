class AddTravelerPricingToPrices < ActiveRecord::Migration[7.1]
  def change
    add_belongs_to :prices, :traveler_pricing, null: true, foreign_key: true, type: :uuid
  end
end
