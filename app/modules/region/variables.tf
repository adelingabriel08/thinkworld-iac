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
