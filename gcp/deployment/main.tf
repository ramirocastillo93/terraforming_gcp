module "gke" {
  source                  = "../modules/gke"
  project_id              = var.project_id
  region                  = var.region
  gke_num_nodes           = var.gke_num_nodes
  gke_preemtible          = var.gke_preemtible
  gke_machine_type        = var.gke_machine_type
  gke_disabled_hpa        = var.gke_disabled_hpa
  gke_cluster_autoscaling = var.gke_cluster_autoscaling
}

module "gke_vpc" {
  source     = "../modules/vpc"
  project_id = var.project_id
  region     = var.region
}