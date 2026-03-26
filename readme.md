Particle41 DevOps Challenge: SimpleTimeService
This project is my submission for the Particle41 DevOps Team Challenge. It automates the deployment of a containerized Python microservice onto a highly available AWS EKS cluster using Terraform.

What's Inside?
SimpleTimeService: A minimalist Python/Flask app that returns a JSON response with the current timestamp and the requester's IP.

Infrastructure: A custom VPC with 2 public and 2 private subnets across multiple AZs.

Orchestration: AWS EKS (v1.31) with worker nodes residing strictly in private subnets for better security.

Security Focus: The application runs as a non-root user inside the container, and the EKS cluster uses modern Access Entries for IAM-to-K8s authentication.

Project Structure
Plaintext
.
├── app/
│   ├── main.py            # Flask application
│   ├── requirements.txt   # Dependencies
│   └── Dockerfile         # Multi-stage, non-root build
├── terraform/
│   ├── main.tf            # VPC & EKS Module definitions
│   ├── variables.tf       # Parameter definitions
│   └── terraform.tfvars   # Custom values (Region, CIDRs, etc.)
└── microservice.yml       # K8s Deployment & Service (ClusterIP)

Prerequisites
Before starting, ensure you have the following installed and configured:

AWS CLI: Configured with valid credentials (aws configure).

Terraform: v1.0 or higher.

kubectl: To manage the cluster once it's live.

Docker: For building/testing the app locally.

How to Deploy
1. Provision the Infrastructure
The Terraform code uses verified modules to build the networking and the EKS control plane. This step usually takes about 15-20 minutes.

Bash
cd terraform
terraform init
terraform apply --auto-approve
2. Connect to the Cluster
Once the apply is successful, update your local kubeconfig to interact with the new cluster:

Bash
aws eks update-kubeconfig --region us-east-1 --name p41-eks-cluster
3. Deploy the Service
The application is deployed using a standard Deployment and a ClusterIP Service (as per the challenge requirements).

Bash
cd ..
kubectl apply -f microservice.yml
4. Verify & Test
Since the service is a ClusterIP (internal only), use port-forwarding to test it from your local machine:

Bash
# Check if pods are running
kubectl get pods

# Start the tunnel
kubectl port-forward service/time-service-svc 8080:80
Open a separate terminal and run:

Bash
curl http://localhost:8080
Technical Notes & Assumptions
Cost Management: I utilized a single_nat_gateway = true in the VPC module to reduce AWS costs while still providing internet access for the private nodes to pull images.

Kubernetes Version: I've pinned the cluster to v1.31 to utilize the latest stable features and security patches.

Auth Mode: I enabled API_AND_CONFIG_MAP to ensure smooth authentication via the vscode IAM user that provisions the resources.

Cleanup
To avoid ongoing AWS charges for EKS and NAT Gateways, run:

Bash
cd terraform
terraform destroy --auto-approve
Final Step for you, Avishek:
Copy-paste this into your README.md on your computer.

Commit and Push:

Bash
git add README.md
git commit -m "docs: finalize professional readme with deployment details"
git push origin main