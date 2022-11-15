resource "kubernetes_namespace" "new_namespace" {
  metadata {
    annotations = {
      name = "${var.ns_name}"
    }
  }
}