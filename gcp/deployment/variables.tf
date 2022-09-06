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

variable "is_preemtible" {
  default     = ""
  description = "Boolean variable for setting preemtible machines or not on GKE cluster"
  type        = "boolean"
}