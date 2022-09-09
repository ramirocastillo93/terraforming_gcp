variable "project_id" {
  default     = ""
  description = "GCP project id"
  type        = string
}

variable "region" {
  default     = ""
  description = "GCP project region"
  type        = string
}

variable "gke_num_nodes" {
  default     = 2
  description = "Number of GKE Nodes"
  type        = number
}

variable "gke_preemtible" {
  default     = ""
  description = "Boolean variable for setting preemtible machines or not on GKE cluster"
  type        = bool
}

variable "gke_machine_type" {
  default     = ""
  description = "GKE machine type"
  type        = string
}

variable "gke_disabled_hpa" {
  default     = ""
  description = "Boolean. Is HPA disabled?"
  type        = bool
}

variable "gke_cluster_autoscaling" {
  default     = ""
  description = "Object with information for enabling GKE cluster autoscaling"
  type = object({
    enabled        = bool
    cpu_minimum    = number
    cpu_maximum    = number
    memory_minimum = number
    memory_maximum = number
  })
}