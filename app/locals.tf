locals {
  product            = "ThinkWorld"
  product_short_code = "tw" # ThinkWorld

  # These values are either constants or calculated values. They don't need to be changed.
  lifecycle = "app"
  suffix    = "${local.product_short_code}-${local.lifecycle}-${var.environment}"
  tags = {
    environment = var.environment
    product     = local.product
  }

  storage_account_suffix = "${local.product_short_code}${local.lifecycle}${var.environment}"

  # Subscription Level
  monitoring_lifecycle_suffix = "${local.product_short_code}-mon-${var.environment}"
  data_lifecycle_suffix       = "${local.product_short_code}-data-${var.environment}"

  networks = {
    for index, region in var.deployment_regions :
    "${local.product_short_code}-net-${var.environment}-${module.azure_region[index].location_short}" => {
      suffix         = "${local.product_short_code}-net-${var.environment}-${module.azure_region[index].location_short}"
      location       = module.azure_region[index].location_cli
      location_short = module.azure_region[index].location_short
    }
  }
}
