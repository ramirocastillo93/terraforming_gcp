project_id = "developing-stuff"

region = "us-east4"

gke_num_nodes = {
  max = 2
  min = 1
}

gke_preemptible = false

gke_machine_type = "n1-standard-1"

gke_subnet_ip_cidr_range = "10.51.0.0/20"

gke_cluster_autoscaling = {
  enabled        = true
  cpu_minimum    = 1
  cpu_maximum    = 1
  memory_minimum = 2
  memory_maximum = 4
}

gke_disabled_hpa = true

env_name = "prod"

cluster_name = "onlineboutique"

ip_range_pods_name = "ip-range-pods-name"

ip_range_services_name = "ip-range-services-name"