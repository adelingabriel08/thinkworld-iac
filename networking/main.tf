module "primary_region" {
  source = "./modules/region"

  suffix               = "${local.suffix}-${module.azure_region.location_short}"
  environment          = var.environment
  tags                 = local.tags
  vnet_address_space   = var.primary_region_vnet_address_space
  law_id               = data.azurerm_log_analytics_workspace.main.id

  location_object = {
    name       = module.azure_region.location
    short_name = module.azure_region.location_short
  }
}

# module "secondary_region" {
#   source = "./modules/region"
#   count  = var.secondary_region_vnet_address_space != null ? 1 : 0

#   suffix               = "${local.suffix}-${module.azure_region.paired_location.location_short}"
#   environment          = local.tags
#   tags                 = module.standard_tags.tags
#   vnet_address_space   = var.secondary_region_vnet_address_space
#   law_id               = data.azurerm_log_analytics_workspace.main.id

#   location_object = {
#     name       = module.azure_region.paired_location.location
#     short_name = module.azure_region.paired_location.location_short
#   }
# }
