module "paymentservice" {
  source   = "../../modules"
  env      = var.env
  app_name = var.app_name
}