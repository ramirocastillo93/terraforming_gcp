# GKE Cluster
resource "google_container_cluster" "primary" {
  name                     = "${var.cluster_name}-${var.env_name}"
  location                 = var.region
  remove_default_node_pool = true
  initial_node_count       = 1

  network    = var.network
  subnetwork = var.subnetwork

  cluster_autoscaling {
    enabled = var.gke_cluster_autoscaling.enabled
    resource_limits {
      resource_type = "cpu"
      minimum       = var.gke_cluster_autoscaling.cpu_minimum
      maximum       = var.gke_cluster_autoscaling.cpu_maximum
    }
    resource_limits {
      resource_type = "memory"
      minimum       = var.gke_cluster_autoscaling.memory_minimum
      maximum       = var.gke_cluster_autoscaling.memory_maximum
    }
  }

  addons_config {
    horizontal_pod_autoscaling {
      disabled = var.gke_disabled_hpa
    }
  }
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
      env       = var.env_name
      terraform = true
    }

    preemptible  = var.gke_preemtible
    machine_type = var.gke_machine_type
    tags = [
      "gke-node",
      "${var.cluster_name}-${var.env_name}"
    ]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}