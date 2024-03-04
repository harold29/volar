class AddCurrencyToFlightOffers < ActiveRecord::Migration[7.1]
  def change
    add_reference :flight_offers, :currency, null: false, foreign_key: true, type: :uuid
  end
end
