variable "location" {
  type        = string
  description = "The location of the resources"
  default     = "uksouth"
}

variable "environment" {
  description = "The Environment being deployed to."
  type        = string
  default     = "dev"
}

variable "replication_regions" {
  description = "The list of other regions to replicate to."
  type        = set(string)
  default     = ["eastus"]
}

