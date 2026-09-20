terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

resource "docker_image" "akhq" {
  name         = "tchiotludo/akhq:0.25.1"
  keep_locally = true
}

resource "docker_container" "akhq" {
  name  = "akhq"
  image = docker_image.akhq.image_id

  ports {
    internal = 8080
    external = 8080
  }

  env = [
    "AKHQ_CONFIGURATION=${<<-EOT
      akhq:
        connections:
          local:
            properties:
              bootstrap.servers: "${var.kafka_broker}"
    EOT
    }"
  ]

  networks_advanced {
    name = var.network_name
  }

  lifecycle {
    ignore_changes = [network_mode]
  }
}