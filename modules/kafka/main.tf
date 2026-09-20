terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

resource "docker_image" "zookeeper" {
  name         = "confluentinc/cp-zookeeper:7.5.0"
  keep_locally = true
}

resource "docker_container" "zookeeper" {
  name  = "zookeeper"
  image = docker_image.zookeeper.image_id

  env = [
    "ZOOKEEPER_CLIENT_PORT=2181",
    "ZOOKEEPER_TICK_TIME=2000"
  ]

  networks_advanced {
    name = var.network_name
  }

  lifecycle {
    ignore_changes = [network_mode]
  }
}

resource "docker_image" "kafka" {
  name         = "confluentinc/cp-kafka:7.5.0"
  keep_locally = true
}

resource "docker_container" "kafka" {
  name  = "kafka"
  image = docker_image.kafka.image_id

  ports {
    internal = 9092
    external = 9092
  }

  env = [
    "KAFKA_BROKER_ID=1",
    "KAFKA_ZOOKEEPER_CONNECT=zookeeper:2181",
    "KAFKA_LISTENER_SECURITY_PROTOCOL_MAP=PLAINTEXT:PLAINTEXT,PLAINTEXT_HOST:PLAINTEXT",
    "KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://kafka:29092,PLAINTEXT_HOST://localhost:9092",
    "KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR=1"
  ]

  networks_advanced {
    name = var.network_name
  }

  healthcheck {
    test     = ["CMD", "nc", "-z", "localhost", "9092"]
    interval = "5s"
    timeout  = "3s"
    retries  = 10
  }

  wait = true

  lifecycle {
    ignore_changes = [network_mode]
  }

  depends_on = [
    docker_container.zookeeper
  ]
}