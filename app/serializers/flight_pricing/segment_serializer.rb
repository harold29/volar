module FlightPricing
  class SegmentSerializer < BaseSerializer
    attributes :departure,
               :arrival,
               :carrier_code,
               :number,
               :aircraft,
               :operating,
               :duration,
               :number_of_stops,
               :id,
               :blacklisted_in_EU

    has_many :stops, serializer: FlightPricing::StopSerializer

    def departure
      {
        iata_code: object.departure_airport.iata_code,
        terminal: object.departure_terminal,
        at: object.departure_at.strftime('%Y-%m-%dT%H:%M:%S')
      }
    end

    def arrival
      {
        iata_code: object.arrival_airport.iata_code,
        terminal: object.arrival_terminal,
        at: object.arrival_at.strftime('%Y-%m-%dT%H:%M:%S')
      }
    end

    def carrier_code
      object.carrier.code
    end

    def number
      object.flight_number
    end

    def aircraft
      {
        code: object.aircraft_code
      }
    end

    def operating
      {
        carrier_code: object.carrier.code
      }
    end

    def duration
      object.duration # TODO: add missing information
    end

    def number_of_stops
      object.stops_number
    end

    def id
      object.internal_id
    end

    def blacklisted_in_EU
      object.blacklisted_in_eu
    end

    # def stops
    #   return unless instance_options[:depth].nil? || instance_options[:depth] > 0

    #   object.stops.map do |stop|
    #     FlightPricing::StopSerializer.new(stop, scope:, depth: instance_options[:depth] ? instance_options[:depth] - 1 : nil).serializable_hash
    #   end
    # end
  end
end
