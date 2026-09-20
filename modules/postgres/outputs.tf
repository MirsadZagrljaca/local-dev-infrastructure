output "connection_string" {
  value       = "localhost:5432/${var.postgres_db}"
  description = "Local connection endpoint for database connections"
}

output "container_name" {
  value       = docker_container.postgres.name
  description = "PostgreSQL Docker container name"
}