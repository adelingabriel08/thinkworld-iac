variable "suffix" {
  type = string
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

variable "tags" {
  type = map(string)
}

variable "private_dns_zone_resource_group_name" {
  type = string
}

variable "database_name" {
  type = string
}

variable "resource_group" {
  type = string
}

variable "replication_networks" {
  type = map(object(
    {
      suffix         = string
      location       = string
      location_short = string
    }
  ))
  default = {}
}
