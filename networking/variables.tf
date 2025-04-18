variable "location" {
  type        = string
  description = "The location of the resources"
  default     = "uksouth"
}

variable "secondary_location" {
  type        = string
  description = "The location of the resources"
  default     = "eastus"
}

variable "environment" {
  description = "The Environment being deployed to."
  type        = string
  default     = "dev"
}

variable "primary_region_vnet_address_space" {
  description = "The region specific vnet address space for the primary region."
  type        = list(string)
  default     = ["10.0.1.0/27", "10.0.2.0/28"]
}

variable "secondary_region_vnet_address_space" {
  description = "The region specific vnet address space for the secondary region, if not provided the secondary region will not be built."
  type        = list(string)
  default     = ["10.1.1.0/27", "10.1.2.0/28"]
  nullable    = true
}
