release_group = {
  "istio-base" = {
    name            = "istio-base"
    repository      = "https://istio-release.storage.googleapis.com/charts"
    chart           = "base"
    timeout         = 120
    cleanup_on_fail = true
    namespace       = "istio-system"
    force_update    = false
  },
  "istiod" = {
    name            = "istiod"
    repository      = "https://istio-release.storage.googleapis.com/charts"
    chart           = "istiod"
    timeout         = 120
    cleanup_on_fail = true
    namespace       = "istio-system"
    force_update    = false

  },
  "istio-ingress" = {
    name            = "istio-ingress"
    repository      = "https://istio-release.storage.googleapis.com/charts"
    chart           = "gateway"
    timeout         = 500
    cleanup_on_fail = true
    force_update    = false
    namespace       = "istio-ingress"
  }
}