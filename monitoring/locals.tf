locals {
  product            = "ThinkWorld"
  product_short_code = "tw" # ThinkWorld

  # These values are either constants or calculated values. They don't need to be changed.
  lifecycle              = "mon"
  suffix                 = "${local.product_short_code}-${local.lifecycle}-${var.environment}"
  storage_account_suffix = "st${replace(local.suffix, "-", "")}"
  location               = "uksouth"
  tags = {
    environment = var.environment
    product     = local.product
  }
}
