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
  default     = "10.51.0.0/20"
  description = "ip cidr range for gcp subnet"
  type        = string
}