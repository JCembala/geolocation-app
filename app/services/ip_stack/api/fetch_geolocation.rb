# frozen_string_literal: true

module IpStack
  module Api
    class FetchGeolocation
      def self.call(...)
        new(...).call
      end

      def initialize(network_address:)
        @network_address = network_address
      end

      def call
        raise_error unless success?

        parsed_response
      end

      private

      def parsed_response
        @parsed_response ||= JSON.parse(response.body)

      rescue JSON::ParserError
        raise IpStack::Api::Error, 'Invalid response from IpStack API.'
      end

      def response
        url = URI("http://api.ipstack.com/#{network_address}?access_key=#{access_key}")

        @response ||= HTTParty.get(url)
      end

      def access_key
        ENV.fetch('IPSTACK_API_KEY')
      end

      def success?
        response.code.between?(200, 299)
      end

      def raise_error
        raise IpStack::Api::Error, error_message
      end

      def error_message
        error = parsed_response.fetch('error', {})

        {
          HttpStatus: error.fetch('code', 500),
          Type: error.fetch('type', 'unknown_error'),
          Info: error.fetch('info', 'An unknown error occurred.')
        }.to_json
      end

      attr_reader :network_address
    end
  end
end
