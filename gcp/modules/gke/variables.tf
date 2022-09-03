variable "project_id" {
  default     = ""
  description = "GCP project id"
}

variable "region" {
  default     = ""
  description = "GCP project region"
}

variable "gke_num_nodes" {
  default     = 2
  description = "Number of GKE Nodes"
}