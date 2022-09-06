output "gcp_vpc" {
  value = google_compute_network.vpc
  # precondition {

  # }
}

output "gcp_subnet" {
  value = google_compute_subnetwork.subnet
  # precondition {

  # }
}