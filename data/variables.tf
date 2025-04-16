variable "location" {
  type        = string
  description = "The location of the resources"
  default     = "uksouth"
}

variable "environment" {
  description = "The Environment being deployed to."
  type        = string
}

variable "replication_regions" {
  description = "The list of other regions to replicate to."
  type        = list(string)
  default     = []
}

