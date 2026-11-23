terraform {
  # Write-only attributes need Terraform 1.11.
  required_version = ">= 1.11"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      # 6.50.0 switches from `secret_string` to `secret_string_wo` in place when the value is unchanged.
      version = ">= 6.50"
    }
    rollbar = {
      source  = "rollbar/rollbar"
      version = ">= 1.0"
    }
  }
}
