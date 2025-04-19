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
  features {
    resource_group {
       prevent_deletion_if_contains_resources = false
       }
  }
  storage_use_azuread = true
  subscription_id     = "fcefe8af-f8f7-4628-b54c-f4029edff8fb"
}

