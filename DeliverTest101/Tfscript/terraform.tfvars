cloud_provider        = "aws"
region               = "ap-southeast-1"
eks_cluster_name     = "my-eks-cluster"
fargate_profile_name = "my-fargate-profile"
vpc_cidr             = "10.0.0.0/16"
private_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
public_subnet_cidrs   = "10.0.3.0/24"  # New public subnet for EC2
ec2_instance_type    = "t3.medium"

