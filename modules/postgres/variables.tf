variable "network_name" {
  type        = string
  description = "Name of the Docker network to attach the container to"
}

variable "postgres_db" {
  type        = string
  default     = "orders"
  description = "PostgreSQL database name"
}

variable "postgres_user" {
  type        = string
  default     = "api_user"
  description = "PostgreSQL superuser username"
}

variable "postgres_password" {
  type        = string
  default     = "password"
  sensitive   = true
  description = "PostgreSQL superuser password"
}