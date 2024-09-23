provider "aws" {
  region = "locale"
}

locals {
  rollbar_tokens = [
    {
      name         = "example"
      access_token = "example"
    },
    {
      name         = "example2"
      access_token = "example2"
    }
  ]
}

module "secretsmanager" {
  source = "./.."

  name_prefix = "example"

  rollbar_tokens = local.rollbar_tokens

  default_tags = {
    app = "example"
    env = "production"
  }
}
