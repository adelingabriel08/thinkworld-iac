module "primary_region" {
  source = "./modules/region"

  suffix             = "${local.suffix}-${module.azure_primary_region.location_short}"
  environment        = var.environment
  tags               = local.tags
  vnet_address_space = var.primary_region_vnet_address_space
  law_id             = data.azurerm_log_analytics_workspace.main.id

  location_object = {
    name       = module.azure_primary_region.location
    short_name = module.azure_primary_region.location_short
  }
}

module "secondary_region" {
  source = "./modules/region"
  count  = var.secondary_region_vnet_address_space != null ? 1 : 0

  suffix             = "${local.suffix}-${module.azure_secondary_region.location_short}"
  environment        = var.environment
  tags               = local.tags
  vnet_address_space = var.secondary_region_vnet_address_space
  law_id             = data.azurerm_log_analytics_workspace.main.id

  location_object = {
    name       = module.azure_secondary_region.location
    short_name = module.azure_secondary_region.location_short
  }
}
