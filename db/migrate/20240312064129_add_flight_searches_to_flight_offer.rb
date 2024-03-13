class AddFlightSearchesToFlightOffer < ActiveRecord::Migration[7.1]
  def change
    add_reference :flight_offers, :flight_search, foreign_key: true, type: :uuid
  end
end
