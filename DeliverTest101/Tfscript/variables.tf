variable "cloud_provider" {
  description = "Choose the cloud provider: aws or gcp"
  type        = string
  default     = "aws"
}

variable "region" {
  description = "Region where infrastructure will be deployed"
  type        = string
  default     = "ap-southeast-1"
}

variable "eks_cluster_name" {
  description = "Name of the EKS Cluster"
  type        = string
  default     = "eks-cluster"
}

variable "fargate_profile_name" {
  description = "Fargate profile name"
  type        = string
  default     = "default-fargate-profile"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "private_subnet_cidrs" {
  description = "List of subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnet_cidrs" {
  description = "List of subnet CIDRs"
  type        = string
  default     = "10.0.3.0/24"
}


