module FlightPricing
  class ItinerarySerializer < BaseSerializer
    # TODO: add duration missing information
    attributes :duration

    has_many :segments, serializer: FlightPricing::SegmentSerializer

    # def segments
    #   return unless instance_options[:depth].nil? || instance_options[:depth] > 0

    #   object.segments.map do |segments|
    #     SegmentSerializer.new(segments, scope:, depth: instance_options[:depth] ? instance_options[:depth] - 1 : nil).serializable_hash
    #   end
    # end
  end
end
