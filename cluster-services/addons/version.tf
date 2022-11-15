terraform {
  required_version = ">= 1.0.0"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.3.0"
    }
  }
  backend "gcs" {
    bucket = "terraforming_gke"
    prefix = "addons_state"
  }
}