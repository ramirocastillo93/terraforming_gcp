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
  default     = true
  description = "Boolean variable for setting preemtible machines or not on GKE cluster"
  type        = bool
}

variable "gke_machine_type" {
  default     = ""
  description = "GKE machine type"
  type        = string
}

variable "gke_disabled_hpa" {
  default     = false
  description = "Boolean. Is HPA disabled?"
  type        = bool
}

variable "gke_cluster_autoscaling" {
  default = {
    enabled        = true
    cpu_minimum    = 2
    cpu_maximum    = 4
    memory_minimum = 4
    memory_maximum = 16
  }
  description = "Object with information for enabling GKE cluster autoscaling"
  type = object({
    enabled        = bool
    cpu_minimum    = number
    cpu_maximum    = number
    memory_minimum = number
    memory_maximum = number
  })
}

variable "cluster_name" {
  description = "The name for the GKE cluster"
  type        = string
}

variable "env_name" {
  description = "The environment for the GKE cluster"
  default     = "dev"
  type        = string
}

variable "network" {
  description = "The VPC network created to host the cluster in"
  default     = "gke-network"
}

variable "subnetwork" {
  description = "The subnetwork created to host the cluster in"
  default     = "gke-subnet"
  type        = string
}