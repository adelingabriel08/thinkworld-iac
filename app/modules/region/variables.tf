variable "suffix" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "network" {
  type = object(
    {
      suffix         = string
      location       = string
      location_short = string
    }
  )
}

variable "storage_account_suffix" {
  type = string
}

variable "data_lifecycle_preffix" {
  type = string
}

variable "global_cosmos_db_id" {
  description = "Resource ID of the global Cosmos DB account."
  type        = string
}

variable "router_cosmos_db_id" {
  description = "Resource ID of the router Cosmos DB account."
  type        = string
}

variable "global_tm_profile_name" {
  description = "The name of the global Traffic Manager profile."
  type        = string
}

variable "router_tm_profile_name" {
  description = "The name of the router Traffic Manager profile."
  type        = string
}

variable "global_tm_profile_id" {
  description = "The resource ID of the global Traffic Manager profile."
  type        = string
}

variable "router_tm_profile_id" {
  description = "The resource ID of the router Traffic Manager profile."
  type        = string
}
