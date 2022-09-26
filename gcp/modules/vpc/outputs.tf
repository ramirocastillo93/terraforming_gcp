output "gcp_vpc_name" {
  value = google_compute_network.vpc.name
}

output "gcp_subnet_name" {
  value = google_compute_subnetwork.subnet.name
}