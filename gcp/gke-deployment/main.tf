# Create a new private K8s cluster
# Source: https://github.com/terraform-google-modules/terraform-google-kubernetes-engine/tree/master/modules/private-cluster
module "gke" {
  source     = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  version    = "= 23.1.0"
  name       = "${var.cluster_name}-${var.env_name}"
  project_id = var.project_id
  region     = var.region
  network    = module.gke_vpc.network_name
  # subnetwork                      = module.gke_vpc.subnets["subnet_name"]
  subnetwork                      = "${var.subnetwork}-${var.env_name}"
  ip_range_pods                   = var.ip_range_pods_name
  ip_range_services               = var.ip_range_services_name
  horizontal_pod_autoscaling      = var.gke_disabled_hpa
  enable_vertical_pod_autoscaling = var.gke_disabled_vpa
  cluster_autoscaling = {
    enabled       = var.gke_cluster_autoscaling.enabled
    min_cpu_cores = var.gke_cluster_autoscaling.cpu_minimum
    max_cpu_cores = var.gke_cluster_autoscaling.cpu_maximum
    min_memory_gb = var.gke_cluster_autoscaling.memory_minimum
    max_memory_gb = var.gke_cluster_autoscaling.memory_maximum
    gpu_resources = []
  }

  node_pools = [
    {
      name                     = "${var.cluster_name}-${var.env_name}-node-pool"
      machine_type             = var.gke_machine_type
      node_locations           = "us-east4-a"
      min_count                = var.gke_num_nodes.min
      max_count                = var.gke_num_nodes.max
      preemptible              = var.gke_preemptible
      initial_node_count       = var.gke_num_nodes.min
      remove_default_node_pool = true
    }
  ]

  depends_on = [
    module.gke_vpc
  ]
}

# Create a VPC
# Source: https://github.com/terraform-google-modules/terraform-google-network
module "gke_vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 4.0"

  project_id   = var.project_id
  network_name = "${var.network}-${var.env_name}"
  # routing_mode = "GLOBAL"
  subnets = [
    {
      subnet_name   = "${var.subnetwork}-${var.env_name}"
      subnet_ip     = var.gke_subnet_ip_cidr_range
      subnet_region = var.region
    }
  ]
  secondary_ranges = {
    "${var.subnetwork}-${var.env_name}" = [
      {
        ip_cidr_range = "10.61.0.0/20"
        range_name    = var.ip_range_pods_name
      },
      {
        ip_cidr_range = "10.71.0.0/20"
        range_name    = var.ip_range_services_name
      }
    ]
  }
}

# GKE Auth for retrieving token
# Source: https://github.com/terraform-google-modules/terraform-google-kubernetes-engine/tree/master/modules/auth
module "gke_auth" {
  source               = "terraform-google-modules/kubernetes-engine/google//modules/auth"
  project_id           = var.project_id
  cluster_name         = module.gke.name
  location             = module.gke.location
  use_private_endpoint = true
  depends_on = [
    module.gke
  ]
}

# Save kubeconfig file 
resource "local_file" "kubeconfig" {
  content  = module.gke_auth.kubeconfig_raw
  filename = "./kubeconfig-${var.env_name}"

  depends_on = [
    module.gke_auth
  ]
}