module "gke_module" {
  source        = "../modules/gke"
  project_id    = var.project_id
  region        = var.region
  gke_num_nodes = var.gke_num_nodes
}

module "gke_vpc" {
  source     = "../modules/vpc"
  project_id = var.project_id
  region     = var.region
}