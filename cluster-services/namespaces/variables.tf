variable "ns_names" {
  description = "Namespace names"
  type = map(
    object({
      ns_name = string
    })
  )
}