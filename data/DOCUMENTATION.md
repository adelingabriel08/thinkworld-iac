# Data Terraform Module Documentation

## Overview
This folder manages data resources, primarily Cosmos DB accounts and their networking, for ThinkWorld. It supports multi-region replication and private endpoints.

## Resources
- **azurerm_resource_group.main / pii**: Resource groups for main and PII data.
- **module.pii_cosmos / global_cosmos / router_cosmos**: Each is an instance of the Cosmos DB module for different data domains.

### In modules/cosmos:
- **azurerm_cosmosdb_account.main**: Cosmos DB account with geo-replication.
- **azurerm_cosmosdb_sql_database.database**: SQL database in Cosmos DB.
- **azurerm_private_endpoint.private_endpoint / private_endpoint_regions**: Private endpoints for Cosmos DB in primary and replication regions.

## Modules
- **module.azure_primary_region / azure_region**: Claranet regions module for region info.
- **module.pii_cosmos / global_cosmos / router_cosmos**: Cosmos DB deployments for different data types.

## Data Sources
- **data.azurerm_subnet.endpoints / replication_region**: Looks up subnets for private endpoints.
- **data.azurerm_resource_group.main / dns_zone_resource_group**: Resource group lookups.
- **data.azurerm_private_dns_zone.cosmos / replication_zone**: DNS zones for Cosmos DB endpoints.

## Outputs
- Cosmos DB account IDs, names, and endpoints.

## Coupling
- Strong coupling to the networking layer for subnet and DNS zone lookups.
- Replication networks are dynamically built from the regions module and passed to Cosmos modules.
- Resource group and DNS zone names must match those created by the networking module.
