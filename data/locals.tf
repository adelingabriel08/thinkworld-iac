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
  region_suffix   = "${local.suffix}-${module.azure_primary_region.location_short}"

  region_network = {
    suffix         = "${local.product_short_code}-net-${var.environment}-${module.azure_primary_region.location_short}"
    location       = module.azure_primary_region.location_cli
    location_short = module.azure_primary_region.location_short
  }

  replication_networks = {
    for index, region in var.replication_regions :
    "${local.product_short_code}-net-${var.environment}-${module.azure_region[index].location_short}" => {
      suffix         = "${local.product_short_code}-net-${var.environment}-${module.azure_region[index].location_short}"
      location       = module.azure_region[index].location_cli
      location_short = module.azure_region[index].location_short
    }
  }

  # Combine primary and replica PII Cosmos DBs into a single for_each
  all_pii_cosmos_networks = merge(
    {
      primary = {
        suffix         = "${local.suffix}-pii-${module.azure_primary_region.location_short}"
        network        = local.region_network
        private_dns_zone_resource_group_name = "rg-${local.region_network.suffix}"
      }
    },
    {
      for k, v in local.replication_networks :
      k => {
        suffix         = "${local.suffix}-pii-${v.location_short}"
        network        = v
        private_dns_zone_resource_group_name = "rg-${v.suffix}"
      }
    }
  )
}
