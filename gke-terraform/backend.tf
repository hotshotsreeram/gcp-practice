terraform {
  backend "gcs" {
    bucket         = "terraform-backend-gcp"
    prefix         = "gcp/gke/infrastructure.tfstate"
  }
}