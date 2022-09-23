module "gke_vpc" {
  source                   = "../modules/vpc"
  env_name                 = var.env_name
  project_id               = var.project_id
  region                   = var.region
  gke_subnet_ip_cidr_range = var.gke_subnet_ip_cidr_range
  subnetwork               = var.subnetwork
  network                  = var.network
}

module "gke" {
  source                  = "../modules/gke"
  env_name                = var.env_name
  cluster_name            = var.cluster_name
  project_id              = var.project_id
  region                  = var.region
  gke_num_nodes           = var.gke_num_nodes
  gke_preemtible          = var.gke_preemtible
  gke_machine_type        = var.gke_machine_type
  gke_disabled_hpa        = var.gke_disabled_hpa
  gke_cluster_autoscaling = var.gke_cluster_autoscaling
  network                 = module.gke_vpc.gcp_vpc_name
  subnetwork              = module.gke_vpc.gcp_subnet_name
}