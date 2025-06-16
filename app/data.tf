data "azurerm_cosmosdb_account" "router" {
  name                = "cosno-${local.data_lifecycle_preffix}-router"
  resource_group_name = "rg-${local.data_lifecycle_preffix}"
}

data "azurerm_cosmosdb_account" "global" {
  name                = "cosno-${local.data_lifecycle_preffix}-global"
  resource_group_name = "rg-${local.data_lifecycle_preffix}"
}