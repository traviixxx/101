module "eks" {
  source          = "./modules/aws"
  providers = {
    aws = aws.aws
  }
  count = var.cloud_provider == "aws" ? 1 : 0
  region          = var.region
  eks_cluster_name = var.eks_cluster_name
  fargate_profile_name = var.fargate_profile_name
  vpc_cidr       = var.vpc_cidr
  private_subnet_cidrs = var.private_subnet_cidrs
  public_subnet_cidrs  = var.public_subnet_cidrs
}

# module "gke" {
#   source         = "./modules/gcp"
#   providers = {
#     google = google.gcp
#   }
#   count = var.cloud_provider == "gcp" ? 1 : 0
# }

