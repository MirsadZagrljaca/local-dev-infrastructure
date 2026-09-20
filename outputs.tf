output "postgres_connection_string" {
  value       = module.postgres.connection_string
  description = "Host connection string for PostgreSQL"
}

output "kafka_broker_endpoint" {
  value       = module.kafka.broker_endpoint
  description = "Local endpoint for external client connections to Kafka"
}

output "akhq_url" {
  value       = "http://localhost:8080"
  description = "URL to access the AKHQ Web UI"
}