project_id               = "developing-stuff"
region                   = "us-east4"
gke_num_nodes            = "2"
gke_preemtible           = true
gke_machine_type         = "n1-standard-1"
gke_subnet_ip_cidr_range = "10.51.0.0/20"
gke_cluster_autoscaling = {
  enabled        = false
  cpu_minimum    = 1
  cpu_maximum    = 4
  memory_minimum = 4
  memory_maximum = 16
}
gke_disabled_hpa = true

