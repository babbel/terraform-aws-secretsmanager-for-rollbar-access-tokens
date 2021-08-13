terraform {
  required_version = ">= 0.13"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    rollbar = {
      source  = "rollbar/rollbar"
      version = "~> 1.0.6"
    }
  }
}
