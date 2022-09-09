project_id               = "dev_project_id"
region                   = "dev_region"
gke_num_nodes            = "dev_gke_num_nodes"
gke_preemtible           = true
gke_machine_type         = "n1-standard-1"
gke_subnet_ip_cidr_range = "10.10.0.0/24"
gke_cluster_autoscaling = {
  enabled        = false
  cpu_minimum    = 1
  cpu_maximum    = 4
  memory_minimum = 4
  memory_maximum = 16
}
gke_disabled_hpa = true

