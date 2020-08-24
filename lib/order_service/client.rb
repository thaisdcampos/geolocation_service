# frozen_string_literal: true

module OrderService
  class Client
    class << self
      def geolocation(id, coordinates)
        endpoint = "#{ENV['ORDER_SERVICE_URL']}/v1/orders/#{id}"

        connection.put(endpoint) do |request|
          request.headers['Content-Type'] = 'application/json'
          request.body = coordinates.to_json
        end
      end

      def connection
        @connection ||= ::Faraday.new do |builder|
          builder.request :json
          builder.response :json, content_type: /\bjson$/
          builder.response :logger, Rails.logger, bodies: true unless Rails.env.test?
          builder.adapter Faraday.default_adapter
        end
      end
    end
  end
end
