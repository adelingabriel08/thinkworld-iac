locals {
  product            = "ThinkWorld"
  product_short_code = "tw" # ThinkWorld

  # These values are either constants or calculated values. They don't need to be changed.
  lifecycle              = "data"
  suffix                 = "${local.product_short_code}-${local.lifecycle}-${var.environment}"
  storage_account_suffix = "st${replace(local.suffix, "-", "")}"
  location               = "uksouth"
  tags                   = {
    environment = var.environment
    product     = local.product
  }

  # Subscription Level
  monitoring_lifecycle_suffix = "${local.product_short_code}-mon-${var.environment}"


  # Region Level
  region_suffix   = "${local.suffix}-${module.azure_region.location_short}"

  region_network = {
    suffix         = "${local.product_short_code}-net-${var.environment}-${module.azure_region.location_short}"
    location       = module.azure_region.location_cli
    location_short = module.azure_region.location_short
  }
}
