require 'singleton'

module Amadeus
  class AccessToken
    include Singleton

    AMADEUS_HOST = ENV['AMADEUS_HOST'] || 'https://test.api.amadeus.com'
    OAUTH_PATH = ENV['AMADEUS_OAUTH_PATH'] || '/v1/security/oauth2/token' # TODO: define new env vars in .env
    TOKEN_BUFFER = ENV['AMADEUS_OAUTH_TOKEN_BUFFER'] || 10
    CLIENT_ID = ENV['AMADEUS_CLIENT_ID']
    CLIENT_SECRET = ENV['AMADEUS_CLIENT_SECRET']

    def bearer_token
      token
    end

    private

    def token
      return @access_token if @access_token && !needs_refresh?

      update_access_token
      @access_token
    end

    def update_access_token
      response = fetch_access_token
      store_access_token(response)
    end

    def needs_refresh?
      @access_token.nil? ||
        (Time.now + TOKEN_BUFFER) > @expires_at
    end

    def store_access_token(data)
      @access_token = data['access_token']
      @expires_at = Time.now + data['expires_in']
    end

    def fetch_access_token
      # TODO: add retry middleware with custom error handling
      response = connection.post do |req|
        req.url OAUTH_PATH
        req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
        req.body = URI.encode_www_form(
          grant_type: 'client_credentials',
          client_id: CLIENT_ID,
          client_secret: CLIENT_SECRET
        )
      end

      JSON.parse(response.body)
    end

    def connection
      @connection ||= Faraday.new(url: AMADEUS_HOST) do |faraday|
        faraday.request :url_encoded
        faraday.adapter Faraday.default_adapter
      end
    end
  end
end
