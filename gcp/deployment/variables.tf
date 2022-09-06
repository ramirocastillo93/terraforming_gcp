variable "project_id" {
  default     = ""
  description = "GCP project id"
  type        = string
}

variable "region" {
  default     = ""
  description = "GCP region"
  type        = string
}

variable "gke_num_nodes" {
  default     = ""
  description = "Number of GKE nodes"
  type        = "number"
}