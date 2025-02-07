provider "aws" {
  region = var.region
  alias  = "aws"
}

# provider "google" {
#  project = var.gcp_project_id
#  region  = var.region
#  alias   = "gcp"
# }
