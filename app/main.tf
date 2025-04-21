module "app" {
  source = "./modules/region"

  for_each = local.networks

  suffix                 = "${local.suffix}-${each.value.location_short}"
  network                = local.networks[each.key]
  tags                   = local.tags
  storage_account_suffix = local.storage_account_suffix
}

# TODOs: 
# managed identities for storage account (could)
# role assignment for cosmos (MUST)
# traffic manager profiles & endpoints (MUST)