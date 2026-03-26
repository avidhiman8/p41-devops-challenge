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



#################

# Particle41 DevOps Challenge - SimpleTimeService

## Overview
This repository contains a production-grade deployment of the `SimpleTimeService`, a Python-based microservice that returns the current timestamp and visitor IP address in JSON format.

## Architecture & Tech Stack
- **Cloud:** AWS (VPC, EKS, IAM, KMS)
- **Orchestration:** Kubernetes v1.31
- **IaC:** Terraform (Modular approach using verified community modules)
- **Application:** Python 3.11 / Flask
- **Security:** - Containers run as a **non-root user**.
  - EKS Nodes reside in **private subnets**.
  - Infrastructure managed via **EKS Access Entries** (modern IAM integration).

## Project Structure
- `/app`: Python source code and Dockerfile.
- `/terraform`: Infrastructure as Code to provision the AWS environment.
- `microservice.yml`: Kubernetes Deployment and Service manifests.

## Deployment Instructions

### 1. Infrastructure Provisioning
Navigate to the terraform directory and initialize the environment:
\`\`\`bash
cd terraform
terraform init
terraform apply --auto-approve
\`\`\`

### 2. Configure Local Access
Update your local kubeconfig to point to the new cluster:
\`\`\`bash
aws eks update-kubeconfig --region us-east-1 --name p41-eks-cluster
\`\`\`

### 3. Application Deployment
Deploy the service to the cluster:
\`\`\`bash
kubectl apply -f microservice.yml
\`\`\`

### 4. Verification
Verify pods are running and test the service via port-forwarding:
\`\`\`bash
kubectl get pods
kubectl port-forward service/time-service-svc 8080:80
# In a separate terminal:
curl http://localhost:8080
\`\`\`
