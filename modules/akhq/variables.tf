variable "network_name" {
  type        = string
  description = "Name of the Docker network to attach AKHQ to"
}

variable "kafka_broker" {
  type        = string
  default     = "kafka:29092"
  description = "Internal Docker network bootstrap server address for Kafka"
}