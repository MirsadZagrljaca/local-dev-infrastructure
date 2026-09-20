output "broker_endpoint" {
  value       = "localhost:9092"
  description = "Kafka bootstrap server address for external applications"
}

output "kafka_container_name" {
  value       = docker_container.kafka.name
  description = "Kafka Docker container name"
}