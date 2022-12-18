module "checkoutservice" {
  source   = "../../modules"
  env      = var.env
  app_name = var.app_name
}