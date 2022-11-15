terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.15.0"
    }
  }
  backend "gcs" {
    bucket = "terraforming_gke"
    prefix = "namespaces_state"
  }
}