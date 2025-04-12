module "azure_region" {
  # checkov:skip=CKV_TF_1:Ensure Terraform module sources use a commit hash - This is a terraform registry thing. Versions here are immutable, so commit hashes aren't needed
  source       = "claranet/regions/azurerm"
  version      = ">= 6"
  azure_region = var.location
}