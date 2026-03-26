# Particle41 DevOps Challenge - SimpleTimeService

## Overview
This repository contains a production-ready deployment of the `SimpleTimeService`, a minimalist Python web service that returns the current timestamp and visitor IP.

## Architecture
- **Infrastructure:** AWS EKS Cluster (v1.29) with 2 x `m6a.large` nodes.
- **Networking:** Custom VPC with 2 Public Subnets (NAT Gateway) and 2 Private Subnets (Nodes).
- **Application:** Containerized Python Flask app running as a non-root user for security.

## Prerequisites
- [AWS CLI](https://aws.amazon.com/cli/) configured with Administrator permissions.
- [Terraform](https://www.terraform.io/downloads.html) (v1.0+)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Docker](https://docs.docker.com/get-docker/)

## Deployment Instructions

### 1. Provision Infrastructure
```bash
cd terraform
terraform init
terraform apply --auto-approve
