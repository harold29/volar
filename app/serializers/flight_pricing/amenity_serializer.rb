module FlightPricing
  class AmenitySerializer < BaseSerializer
    attributes :description,
               :is_chargeable,
               :amenity_type,
               :amenity_provider

    def amenity_provider
      {
        name: object.amenity_provider_name
      }
    end
  end
end
