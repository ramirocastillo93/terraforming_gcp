resource "helm_release" "emailservice" {
  name       = var.release_name
  repository = var.repository_path
  chart      = "../../modules/helm-base/templates/deployment.yaml"
  version    = var.version
  namespace  = var.namespace

  values = [
    file("${path.module}/values.yaml")
  ]
}