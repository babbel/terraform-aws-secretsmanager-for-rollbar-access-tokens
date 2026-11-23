variable "default_tags" {
  type    = map(string)
  default = {}

  description = <<EOS
Map of tags assigned to all AWS resources created by this module.
EOS
}

variable "name_prefix" {
  type = string

  description = <<EOS
Name prefix for the SecretsManager. The full name will be $${var.name_prefix}.rollbar_access_tokens.
EOS
}

variable "rollbar_tokens" {
  type = list(object({
    name         = string
    access_token = string
  }))

  description = <<EOS
List of objects having access tokens names and the token values which shall be loaded into the SecretsManager.
EOS
}

variable "secret_string_wo_version" {
  type    = number
  default = 1

  description = <<EOS
Version of the secret value. Terraform does not compare a write-only value with the stored secret, so changes of `var.rollbar_tokens` are only written when this number changes. Increase it whenever a token is added, removed or replaced.
EOS
}

variable "secretsmanager_secret_tags" {
  type    = map(string)
  default = {}

  description = <<EOS
Map of tags assigned to the SecretsManager secret created by this module. Tags in this map will override tags in `var.default_tags`.
EOS
}
