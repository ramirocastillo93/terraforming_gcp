provider "helm" {
  kubernetes {
    config_path = var.kubeconfig_patha
  }
  alias = "gke"
}

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
    prefix = "emailservice_state"
  }
}

module "emailservice" {
  source = "../../modules"
  env    = var.env
}