class FlightOfferSerializer < ApplicationSerializer
  attributes :id, :source, :instant_ticketing_required, :non_homogeneous, :one_way, :last_ticketing_date, :number_of_bookable_seats, :price_total, :price_currency
end
