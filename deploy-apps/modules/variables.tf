variable "env" {
  type        = string
  description = "The environment name"

  validation {
    condition     = contains(["prod", "dev"], var.env)
    error_message = "ERR! Possible values: prod, dev"
  }
}

variable "app_name" {
    type = string
    description = "Name of the app"
}