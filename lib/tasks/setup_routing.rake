namespace :rabbitmq do
  desc "Setup routing"
  task :setup do
    require "bunny"

    conn = Bunny.new(host: 'rabbitmq', port: '5672', vhost: '/', user: 'guest', pass: 'guest')
    conn.start
    
    ch = conn.create_channel
    x = ch.direct('challenge', :persistent => true)

    queue = ch.queue('geolocation.order.update', :durable => true, :ack => true, :routing_key => 'order_service.order.created')
    queue.bind('challenge', :routing_key => 'order_service.order.created')
    conn.close
  end
end
