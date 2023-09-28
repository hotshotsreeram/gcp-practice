provider "google" {
  project     = "robotic-circle-359714"
  region      = "northamerica-northeast2"  # Change to your desired region
}

module "gke_auth" {
  source               = "terraform-google-modules/kubernetes-engine/google//modules/auth"

  project_id           = var.project_id
  cluster_name         = var.name
  location             = var.location
}

output "helm_host" {
  value = module.gke_auth.host
  sensitive = false
}

output "helm_cluster_ca_certificate" {
  value = module.gke_auth.cluster_ca_certificate
  sensitive = false
}

output "helm_token" {
  value = module.gke_auth.token
  sensitive = false
}


provider "helm" {
  kubernetes {
    host                   =  module.gke_auth.host
    cluster_ca_certificate =  module.gke_auth.cluster_ca_certificate
    token                  = module.gke_auth.token
  }
  debug = true
  alias = "hm"
}

provider "kubernetes" {
  cluster_ca_certificate = module.gke_auth.cluster_ca_certificate
  host                   = module.gke_auth.host
  token                  = module.gke_auth.token
}

resource "local_file" "kubeconfig" {
  content  = module.gke_auth.kubeconfig_raw
  filename = "${path.module}/kubeconfig"
}