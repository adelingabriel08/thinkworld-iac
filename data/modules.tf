module "azure_primary_region" {
  source       = "claranet/regions/azurerm"
  version      = ">= 6"
  azure_region = var.location
}

module "azure_region" {
  source       = "claranet/regions/azurerm"
  for_each     = var.replication_regions
  version      = ">= 6"
  azure_region = each.value
}