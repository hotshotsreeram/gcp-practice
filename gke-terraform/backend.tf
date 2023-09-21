terraform {
  backend "gcs" {
    bucket         = "terraform-backend-gke"
    prefix         = "gcp/gke/infrastructure.tfstate"
  }
}