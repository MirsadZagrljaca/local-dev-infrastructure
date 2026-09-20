resource "docker_network" "shared_net" {
  name = var.network_name
}

module "postgres" {
  source = "./modules/postgres"

  network_name      = docker_network.shared_net.name
  postgres_db       = var.postgres_db
  postgres_user     = var.postgres_user
  postgres_password = var.postgres_password
}

module "kafka" {
  source = "./modules/kafka"

  network_name = docker_network.shared_net.name
}

module "akhq" {
  source = "./modules/akhq"

  network_name = docker_network.shared_net.name
  kafka_broker = "kafka:29092"

  depends_on = [
    module.kafka
  ]
}