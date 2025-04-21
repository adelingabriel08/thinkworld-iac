
module "azure_region" {
  source       = "claranet/regions/azurerm"
  for_each     = var.deployment_regions
  version      = ">= 6"
  azure_region = each.value
}