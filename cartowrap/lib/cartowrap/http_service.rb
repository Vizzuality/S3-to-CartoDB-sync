require 'faraday'
require 'cartowrap/http_service/response'
require 'cartowrap/http_service/endpoint'
module Cartowrap
  module HTTPService
    class << self
    end
    def self.make_request(options, credentials={})
      http_method = options.http_method&.to_sym || :get
      account = credentials["account"]
      endpoint = Endpoint.new(options, credentials).get
      con = Faraday.new(:url => "https://#{account}.cartodb.com") do |faraday|
        faraday.request  :multipart
        faraday.response :logger
        faraday.adapter  Faraday.default_adapter
      end
      response = con.send(http_method) do |req|
        req.url "#{endpoint}"
        req.headers['Content-Type'] = 'application/json' if options.http_method == 'post' || options.http_method == 'put'
        req.body = options.marshal_dump.to_json if options.http_method == 'post' || options.http_method == 'put'
      end
      Cartowrap::HTTPService::Response.new(response.status.to_i, response.body, response.headers)
    end
  end
end
