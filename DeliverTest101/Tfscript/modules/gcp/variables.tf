variable "region" {
  description = "Region where infrastructure will be deployed"
  type        = string
  default     = "ap-southeast-1"
}

variable "gke_cluster_name" {
  description = "Name of the EKS Cluster"
  type        = string
  default     = "eks-cluster"
}