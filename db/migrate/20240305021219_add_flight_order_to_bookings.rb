class AddFlightOrderToBookings < ActiveRecord::Migration[7.1]
  def change
    add_reference :bookings, :flight_order, null: false, foreign_key: true, type: :uuid
  end
end
