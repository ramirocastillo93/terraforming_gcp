provider "kubernetes" {
  config_path = "${var.kubeconfig_path}"
  #   config_context = "my-context"
}