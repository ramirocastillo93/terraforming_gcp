# terraform {
#   required_providers {
#     google = {
#       source  = "hashicorp/google"
#       version = "4.34.0"
#     }
#   }
#   backend "gcs" {
#     bucket = "terraforming_gke"
#     prefix = "state"
#   }
#   # required_version = ">= 1.28.0"
# }