module FlightPricing
  class StopSerializer < BaseSerializer
    attributes :iata_code,
               :duration,
               :arrival_at,
               :departure_at

    def iata_code
      object.airport&.iata_code
    end

    def arrival_at
      object.arrival_at&.strftime('%Y-%m-%dT%H:%M:%S')
    end

    def departure_at
      object.departure_at&.strftime('%Y-%m-%dT%H:%M:%S')
    end
  end
end
