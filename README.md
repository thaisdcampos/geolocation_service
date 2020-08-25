# Geolocation Service

Geolocation is a microservice that enriches a payload with geographic coordinates.

Its mains responsibility is to listen to events with addresses and add latitude and longitude to them. To do that, it currently makes use of the power of [Google Maps API](https://developers.google.com/maps/documentation/javascript/overview), which works on top of [a Geographic coordinate system](https://en.wikipedia.org/wiki/Geographic_coordinate_system).

It was designed to work with events, which means that it does not have a public API to return lat/long information synchronously.

## Environment dependencies

* Ruby 2.7
* RabbitMQ

### Setup
You can use docker to run this app. 

```bash
  docker-compose up -d
  docker-compose exec geo rake db:create
  docker-compose exec geo rake db:migrate
  docker-compose exec geo rake db:test:prepare
  docker-compose exec geo rspec
```

### Logs

```bash
  docker-compose logs -f
```

### Start

```bash
  docker-compose up
```

### Stop

```bash
  docker-compose stop
```

### Tests

```bash
  docker-compose exec geo rspec
```

## Alerts
To execute this project must execute with Order-Service's project, so you need to clone both repositories on the same folder and extract the docker-compose.yml  to root folder. (Both docker-compose.yml are equal)

```bash
  docker-compose up --build
```
