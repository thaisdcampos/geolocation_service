namespace :rabbitmq do
  desc "Setup routing"
  task :setup do
    require "bunny"

    conn = Bunny.new(host: 'rabbitmq', port: '5672', vhost: '/', user: 'guest', pass: 'guest')
    conn.start
    
    ch = conn.create_channel
    x = ch.fanout("challenge")

    queue = ch.queue("order_service.order.created", durable: true)
    queue.bind("challenge")

    conn.close
  end
end
