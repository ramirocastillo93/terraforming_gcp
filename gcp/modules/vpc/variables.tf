variable "project_id" {
  default     = ""
  description = "The project ID"
  type        = string
}

variable "region" {
  default     = ""
  description = "The region of the project"
  type        = string
}

variable "gke_subnet_ip_cidr_range" {
  default     = ""
  description = "IP CIDR range for GCP Subnet"
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