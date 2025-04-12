variable "environment" {
  description = "The Environment being deployed to."
  type        = string
  validation {
    condition = contains(
      [
        "dev",
        "test",
        "prod"
      ],
      var.environment
    )
    error_message = "Environment must be either 'dev', 'test' or 'prod'."
  }
}
