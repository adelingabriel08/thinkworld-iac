# Networking Terraform Module Documentation

## Overview
This folder provisions the core networking infrastructure for ThinkWorld, including virtual networks, subnets, network security groups, and private DNS zones.

## Resources
- **azurerm_virtual_network.main**: Main VNet for each region.
- **azurerm_subnet.endpoints / app_integration**: Subnets for endpoints and app integration.
- **azurerm_network_security_group.endpoints / app_integration**: NSGs for subnets.
- **azurerm_subnet_network_security_group_association**: Associates NSGs with subnets.
- **azurerm_private_dns_zone.primary / secondary**: Private DNS zones for Cosmos DB.
- **azurerm_private_dns_zone_virtual_network_link.primary / secondary**: Links DNS zones to VNets.
- **azurerm_resource_group.main**: Resource group for networking resources.

## Modules
- **module.azure_primary_region / azure_secondary_region**: Claranet regions module for region info.
- **module.primary_region / secondary_region**: Deploys regional networking resources.

## Data Sources
- **data.azurerm_log_analytics_workspace.main**: Used for diagnostic settings (commented out).

## Outputs
- Resource group name, VNet ID, VNet name, suffix.

## Coupling
- Networking resources are referenced by app and data modules for subnet and VNet information.
- Private DNS zones are required for Cosmos DB private endpoints in the data module.
- Consistent naming and tagging conventions ensure cross-module integration.
