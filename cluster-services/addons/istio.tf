resource "helm_release" "istio_base" {
  name            = var.release_group.istio-base.name
  repository      = var.release_group.istio-base.repository
  chart           = var.release_group.istio-base.chart
  timeout         = var.release_group.istio-base.timeout
  cleanup_on_fail = var.release_group.istio-base.cleanup_on_fail
  namespace       = var.release_group.istio-base.namespace
  force_update    = var.release_group.istio-base.force_update

  # Here goes a depends_on with the cluster existence.
}

resource "helm_release" "istiod" {
  name            = var.release_group.istiod.name
  repository      = var.release_group.istiod.repository
  chart           = var.release_group.istiod.chart
  timeout         = var.release_group.istiod.timeout
  cleanup_on_fail = var.release_group.istiod.cleanup_on_fail
  namespace       = var.release_group.istiod.namespace
  force_update    = var.release_group.istiod.force_update

  depends_on = [
    helm_release.istio_base
  ]
}

resource "helm_release" "istio_ingress" {
  name            = var.release_group.istio-ingress.name
  repository      = var.release_group.istio-ingress.repository
  chart           = var.release_group.istio-ingress.chart
  timeout         = var.release_group.istio-ingress.timeout
  cleanup_on_fail = var.release_group.istio-ingress.cleanup_on_fail
  namespace       = var.release_group.istio-ingress.namespace
  force_update    = var.release_group.istio-ingress.force_update

  depends_on = [
    helm_release.istiod
  ]
}