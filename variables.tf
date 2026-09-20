variable "network_name" {
  type        = string
  default     = "app-network"
  description = "Shared Docker network name for all local services"
}

variable "postgres_db" {
  type        = string
  default     = "orders_db"
  description = "PostgreSQL database name"
}

variable "postgres_user" {
  type        = string
  default     = "admin"
  description = "PostgreSQL username"
}

variable "postgres_password" {
  type        = string
  default     = "password123"
  description = "PostgreSQL password"
}