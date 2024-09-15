# provider "aws" {
#   region = var.region # Update region as per your setup
#    version = "~> 5.0"
# }

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
    region = var.region  
}
# S3 bucket for Terraform backend (optional, if using S3 as backend)
resource "aws_s3_bucket" "state-bucket-bhushan" {
  bucket = "my-terraform-state"
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "state-bucket-bhushan" {
  bucket = aws_s3_bucket.state-bucket-bhushan.id
  acl = "private"
}

# Create a VPC for the EKS cluster
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 4.0"  # Upgrade to the latest stable version
  name = "eks-vpc"
  cidr = "10.0.0.0/16"
  azs             = ["ap-south-1"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
  enable_nat_gateway = true
}

# Create an EKS Cluster
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "bhushansc-eks-cluster"
  cluster_version = "1.27"
  subnet_ids = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id
  
 eks_managed_node_groups = {
    eks_nodes = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_type    = "t3.medium"
    }
  }
}
