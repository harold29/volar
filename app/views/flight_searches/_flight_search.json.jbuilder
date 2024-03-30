json.extract! flight_search, :id, :origin, :destination, :departure_date, :return_date, :one_way, :adults, :children, :infants, :travel_class, :created_at
json.url flight_search_url(flight_search, format: :json)
