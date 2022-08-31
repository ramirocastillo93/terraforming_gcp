variable "project_id" {
  default     = ""
  description = "The project ID"
}

variable "region" {
  default     = ""
  description = "The region of the project"
}

variable "gke_username" {
  default     = ""
  description = "GKE Username"
}

variable "gke_password" {
  default     = ""
  description = "GKE Password"
}

variable "gke_num_nodes" {
  default     = 2
  description = "Number of GKE Nodes"
}