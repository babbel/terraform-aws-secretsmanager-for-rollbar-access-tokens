variable "name_prefix" {
  type = string

  description = "Name prefix for the SecretsManager. The full name will be $${var.name_prefix}.rollbar_access_tokens."
}

variable "tags" {
  type    = map(string)
  default = {}

  description = "Tags which will be assigned to all resources."
}

variable "rollbar_tokens" {
  type = list(object({
    name         = string
    access_token = string
  }))

  description = "List of objects having access tokens names and the token values which shall be loaded into the SecretsManager."
}
