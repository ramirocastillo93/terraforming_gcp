resource "helm_release" "application" {
  name  = "application"
  chart = "${path.module}/helm-base"

  values = [
    file("./${var.app_name}.yaml")
  ]
}