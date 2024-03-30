module Amadeus
  class Response
    attr_reader :json_response, :status, :response

    def initialize(response)
      @response = response
      @json_response = response&.body
      @parsed_response = JSON.parse(response&.body)
      @status = response&.status
    rescue JSON::ParserError => e
      # TODO: log the error
      # raise Amadeus::ResponseError, response
      @parsed_response = response&.body
      raise Amadeus::ResponseError, response
    end

    def data
      @parsed_response['data']
    end

    def meta
      @parsed_response['meta']
    end
  end
end
