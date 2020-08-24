class UpdateOrderWorker
  include Sneakers::Worker

  from_queue "geolocation.order.update", env: nil

  def work(payload)
    original_address = payload[:address]
    coordinates = find_coordinates(original_address)

    if coordinates
      OrderService::Client.geolocation(payload[:order_id], build_params(coordinates))
    end

    ack!
  end

  private

  def find_coordinates(address)
    Geocoder.search(address)&.first
  end

  def build_params(coordinates)
    {
      address_attributes: {
        latitude: coordinates.latitude,
        longitude: coordinates.longitude,
      }
    }
  end
end
