terraform {
  required_version = "~> 1.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
  # backend "azurerm" {}
}

provider "azurerm" {
  features {}
  storage_use_azuread = true
  subscription_id     = "30d14272-8daa-42fb-9f53-20b61717552c"
}
