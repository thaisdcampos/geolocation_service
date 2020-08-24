# Geolocation Service

Geolocation Service is responsible for dealing with geolocation. It is responsable to find a coordinates of address.

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
