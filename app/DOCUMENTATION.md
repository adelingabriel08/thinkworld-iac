# App Terraform Module Documentation

## Overview
This folder manages the application layer resources for ThinkWorld, including web apps and function apps, deployed across multiple regions.

## Resources
- **azurerm_resource_group.main**: Resource group for each region.
- **azurerm_service_plan.main**: App Service Plan for hosting web and function apps.
- **azurerm_linux_web_app.global / router / pii**: Three Linux web apps for different purposes (global, router, pii).
- **azurerm_linux_function_app.global / pii**: Two Linux function apps for global and pii workloads.
- **azurerm_storage_account.functions_storage**: Storage account for function apps.

## Modules
- **module.azure_region**: Uses the Claranet regions module to get region info for each deployment region.
- **module.app**: Deploys the app resources for each region using the local.networks map.

## Data Sources
- **data.azurerm_subnet.app_integration**: Looks up the subnet for app integration in the corresponding network.

## Outputs
- App IDs and FQDNs for each web app.
- Resource group name.

## Coupling
- The app resources are tightly coupled to the networking layer via the `data.azurerm_subnet.app_integration` data source, which expects the networking module to have provisioned the required subnets.
- Storage account and service plan are shared by the function apps.
- Tags and naming conventions are consistent across modules for traceability.
