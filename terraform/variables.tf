variable "region" {
  description = "AWS Region"
  default     = "ap-south-1"
}

variable "cluster_name" {
  description = "EKS Cluster Name"
  default     = "my-eks-cluster"
}

variable "instance_type" {
  description = "EC2 instance type for worker nodes"
  default     = "t3.medium"
}