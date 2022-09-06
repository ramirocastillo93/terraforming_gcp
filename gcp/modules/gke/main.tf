# GKE Cluster
resource "google_container_cluster" "primary" {
  name                     = "${var.project_id}-gke"
  location                 = var.region
  remove_default_node_pool = true
  initial_node_count       = 1

  network    = gcp_vpc.name
  subnetwork = gcp_subnet.name
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "${google_container_cluster.primary.name}-node-pool"
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = var.gke_num_nodes

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env       = var.project_id
      terraform = true
    }

    preemptible  = var.gke_preemtible
    machine_type = var.gke_machine_type
    tags = [
      "gke_node",
      "${var.project_id}-gke"
    ]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}