module FlightPricing
  class FareDetailsBySegmentSerializer < BaseSerializer
    attributes :segment_id,
               :cabin,
               :fare_basis,
               :branded_fare,
               :branded_fare_label,
               :class,
               :included_checked_bags

    attribute :flight_class, key: :class

    has_many :amenities, serializer: FlightPricing::AmenitySerializer

    def segment_id
      object.segment_internal_id
    end

    def included_checked_bags
      {
        quantity: object.included_checked_bags
      }
    end

    def flight_class
      object.flight_class
    end

    # TODO: enable additional services
    # def additional_services
    # end
  end
end
