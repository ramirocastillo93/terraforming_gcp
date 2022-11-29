variable "kubeconfig_path" {
  type        = string
  description = "Kubeconfig path from 'TF_VAR_kubeconfig_path'"
}

variable "release_group" {
  description = "Group of helm releases"
  type = map(
    object({
      name            = string
      repository      = string
      chart           = string
      timeout         = number
      cleanup_on_fail = bool
      namespace       = string
      force_update    = bool
  }))
}