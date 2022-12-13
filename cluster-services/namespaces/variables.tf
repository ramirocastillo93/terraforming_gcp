variable "ns_names" {
  description = "Namespace names"
  type = map(
    object({
      ns_name = string
    })
  )
}

variable "kubeconfig_path" {
  type        = string
  description = "Kubeconfig path defined as 'TF_VAR_kubeconfig_path'"
}