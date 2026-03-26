provider "aws" {
  region = var.region
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "p41-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true # Required for private nodes to pull Docker images
  single_nat_gateway = true # Saves money for the assessment
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "p41-eks-cluster"
  cluster_version = "1.31"
  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true
  enable_cluster_creator_admin_permissions = true
  
  authentication_mode = "API_AND_CONFIG_MAP"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets # Requirement: Nodes in private subnets

  eks_managed_node_groups = {
    p41_nodes = {
      instance_types = ["m6a.large"] # Specific requirement
      min_size       = 2
      max_size       = 2
      desired_size   = 2
    }
  }
}
