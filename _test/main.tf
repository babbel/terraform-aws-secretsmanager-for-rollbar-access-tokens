provider "aws" {
  region = "locale"
}

module "secretsmanager" {
  source = "./.."

  name_prefix = "example"

  rollbar_project_name       = "example"
  rollbar_access_token_names = ["post_server_item"]

  tags = {
    app = "example"
    env = "production"
  }
}
