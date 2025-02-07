resource "google_container_cluster" "gke" {
  name     = var.gke_cluster_name
  location = var.region
  enable_autopilot = true  # GKE Autopilot mode (similar to AWS Fargate)

  network    = "default"
  subnetwork = "default"

  deletion_protection = false
}

