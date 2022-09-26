# VPC
resource "google_compute_network" "vpc" {
  name                    = "${var.network}-${var.env_name}"
  auto_create_subnetworks = "false"
  project                 = var.project_id
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.subnetwork}-${var.env_name}"
  region        = var.region
  network       = "${var.network}-${var.env_name}"
  ip_cidr_range = var.gke_subnet_ip_cidr_range
}