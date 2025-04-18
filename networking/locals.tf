locals {
  product            = "ThinkWorld"
  product_short_code = "tw"

  # These values are either constants or calculated values. They don't need to be changed.
  lifecycle                   = "net"
  suffix                      = "${local.product_short_code}-${local.lifecycle}-${var.environment}"
  storage_account_suffix      = "st${replace(local.suffix, "-", "")}"
  location                    = "uksouth"
  monitoring_lifecycle_suffix = "${local.product_short_code}-mon-${var.environment}"
  tags = {
    environment = var.environment
    product     = local.product
  }
}

