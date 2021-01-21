variable "name_prefix" {
  type = string

  description = "Name prefix for the SecretsManager. The full name will be $${var.name_prefix}.rollbar_access_tokens."
}

variable "rollbar_project_name" {
  type = string

  description = "Name of the Rollbar project to load the project access tokens from."
}

variable "rollbar_access_token_names" {
  type    = list(string)
  default = ["post_server_item"]

  description = "List of name of Rollbar access tokens which shall be loaded into the SecretsManager."
}

variable "tags" {
  type    = map(string)
  default = {}

  description = "Tags which will be assigned to all resources."
}
