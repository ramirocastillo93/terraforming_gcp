resource "helm_release" "application" {
  name  = "${var.app_name}-app"
  chart = "${path.module}/helm-base"

  values = [
    file("./${var.app_name}.yaml")
  ]
}