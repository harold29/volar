json.extract! flight_offer, :id, :source, :instant_ticketing_required, :non_homogeneous, :one_way, :last_ticketing_date, :number_of_bookable_seats, :price_total, :price_currency, :created_at, :updated_at
json.url flight_offer_url(flight_offer, format: :json)
