resource "helm_release" "application" {
  name  = "application"
  chart = "${path.module}/helm-base"

  values = [
    file("${path.module}/helm-base/${var.app_name}-${var.env}.yaml")
  ]
}