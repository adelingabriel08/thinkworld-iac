variable "location" {
  type        = string
  description = "The location of the resources"
}

variable "environment" {
  description = "The Environment being deployed to."
  type        = string
}

variable "primary_region_vnet_address_space" {
  description = "The region specific vnet address space for the primary region."
  type        = list(string)
}

# variable "secondary_region_vnet_address_space" {
#   description = "The region specific vnet address space for the secondary region, if not provided the secondary region will not be built."
#   type        = list(string)
#   default     = null
#   nullable    = true
# }
