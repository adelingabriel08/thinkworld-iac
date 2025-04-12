variable "suffix" {
  type = string
}

variable "environment" {
  type = any # Complex object
}

variable "vnet_address_space" {
  type = list(string)
}

variable "tags" {
  type = map(string)
}

variable "location_object" {
  type = object({
    name       = string
    short_name = string
  })
}

variable "law_id" {
  type = string
}
