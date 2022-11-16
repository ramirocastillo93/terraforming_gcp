resource "kubernetes_namespace" "new_namespace" {
  for_each = var.ns_names
  metadata {
    annotations = {
      name = "${each.value.ns_name}"
    }

    name = "${each.value.ns_name}"
  }
}