module Cartowrap
  module HTTPService
    class Endpoint

      attr_reader :options, :credentials

      def initialize(options, credentials = {})
        @options = options
        @credentials  = credentials
      end

      def get
        p options.to_json
        endpoint = "#{endpoint_uri}#{endpoint_querystring}"
      end

      private

      def endpoint_uri
        query = options.q if options.q
        resource = options.resource_id if options.resource_id
        string = ""
        api = options.endpoint
        case api
        when "sql"
          string += "/api/v2/sql/?q=#{query}"
        when "import"
          string += "/api/v1/synchronizations/"
          string += "?#{options.query}" if options.query_string && options.query
        else
        end
        string += resource if resource
        string
      end

      def endpoint_querystring
        p options.query_string
        api_key = credentials["api_key"]
        string = ''
        if options.query_string == false
          string += "?api_key=#{api_key}"
        else
          string += "&api_key=#{api_key}"
        end
        string
      end

    end
  end
  Endpoint = HTTPService::Endpoint
end

