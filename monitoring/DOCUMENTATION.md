# Monitoring Terraform Module Documentation

## Overview
This folder provisions monitoring resources for ThinkWorld, including Log Analytics and Application Insights.

## Resources
- **azurerm_resource_group.main**: Resource group for monitoring resources.
- **azurerm_log_analytics_workspace.main**: Log Analytics workspace for logs and metrics.
- **azurerm_application_insights.main**: Application Insights instance for application monitoring.

## Variables
- **environment**: Controls the environment (dev, test, prod) for resource naming and tagging.

## Coupling
- The Log Analytics workspace is referenced by other modules (e.g., networking) for diagnostic settings.
- Naming conventions and tags are consistent with other folders for traceability.
- No direct resource dependencies on app, data, or networking, but intended for cross-module monitoring integration.
