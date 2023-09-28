terraform {
  required_version = ">= 0.13.1"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 2.2"
    }
    # kubectl = {
    #   source  = "gavinbunney/kubectl"
    #   version = ">= 1.7.0"
    # }
    helm = {
      source  = "hashicorp/helm"
      version = "2.6.0"
    }
    
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.12.1"
    }
  }
}


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
  sensitive = true
}

output "helm_cluster_ca_certificate" {
  value = module.gke_auth.cluster_ca_certificate
  sensitive = true
}

output "helm_token" {
  value = module.gke_auth.token
  sensitive = true
}


provider "helm" {
  kubernetes {
    config_path            =  local_file.kubeconfig.filename
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
  filename = "kubeconfig"
}

output "kubeconfig" {
  value = module.gke_auth.kubeconfig_raw
}