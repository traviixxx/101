variable "public_subnet_cidrs" {
  description = "Public subnet CIDR"
  type        = string
  default     = "10.0.3.0/24"
}

variable "private_subnet_cidrs" {
  description = "List of private subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "ec2_ami" {
  description = "EC2 AMI ID (Amazon Linux 2 suggested)"
  type        = string
  default     = "ami-12345678"
}

variable "ec2_instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t3.medium"
}

variable "ec2_key_name" {
  description = "EC2 Key Pair Name"
  type        = string
  default     = "my-key"
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

variable "azs" {
  description = "List of availability zones for subnets"
  type        = list(string)
  default     = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
}


