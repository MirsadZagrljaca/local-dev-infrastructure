# local-dev-infrastructure
This repository provides a fully automated, reproducible Infrastructure-as-Code (IaC) setup for deploying a complete local development stack consisting of **Apache Kafka**, **AKHQ** (Kafka GUI management tool), and a **PostgreSQL** database using Terraform and the Docker provider.

---

## What This Repo Creates

When you run `terraform apply`, it provisions and configures the following containerized topology on a shared internal Docker network:

1. **PostgreSQL 15 Database (`postgres:15-alpine`)**:
   * Deploys a lightweight Alpine-based Postgres instance.
   * Configures the primary database (`orders`), superuser access (`admin`), and secondary runtime application roles (`api_user`) out of the box.
   * Includes a built-in container health check (`pg_isready`) ensuring dependable startup sequencing.

2. **Apache Kafka Streaming Broker**:
   * Spins up a single-node Kafka broker configured for local event-driven development.
   * Handles high-throughput message streaming and integrates securely within the Docker network bridge.

3. **AKHQ Management Dashboard**:
   * Deploys the AKHQ web user interface linked directly to the Kafka broker.
   * Enables complete real-time visibility into topics, partitions, consumer groups, schemas, and live message payloads through your browser.

4. **Shared Docker Network**:
   * Creates an isolated bridge network ensuring reliable internal service-to-service discovery and DNS resolution.

---

## Prerequisites

Ensure you have the following tools installed and running locally:
* **Terraform** (v1.0 or higher)
* **Docker Desktop** (Running and active)

---

## Quick Start Guide

1. **Initialize Terraform Providers:**
   Initialize the local workspace and download required Docker and local providers:
   ```bash
   terraform init
   ```

2. **Apply the Configuration:**
   Build and launch the entire stack:
   ```bash
   terraform apply
   ```

3. **Verify the Stack:**
   Check that all containers are up, healthy, and bound correctly:
   ```bash
   docker ps
   ```

---

## Clean Slate & Reset Workflow

Because database initialization scripts and environment bootstrapping operate strictly on fresh volumes to prevent configuration drift, use this sequence whenever you need a clean reset:

```bash
terraform destroy
docker volume prune -f
terraform apply
```

---

## Outputs & Access Endpoints

Once successfully applied, Terraform outputs the connection details for your local services:
* **PostgreSQL Connection:** `localhost:5432/orders`
* **Kafka Broker:** `localhost:9092` (internal network listener)
* **AKHQ Web Dashboard:** Accessible via its mapped external port for inspecting streaming topics and data streams in real time `localhost:8080`.