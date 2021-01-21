resource "aws_secretsmanager_secret" "this" {
  name        = "${var.name_prefix}.rollbar_access_tokens"
  description = "Secret value is managed via Terraform"

  tags = var.tags
}

data "rollbar_project" "this" {
  name = var.rollbar_project_name
}

data "rollbar_project_access_token" "this" {
  for_each = toset(var.rollbar_access_token_names)

  project_id = data.rollbar_project.this.id
  name       = each.value
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id = aws_secretsmanager_secret.this.arn

  secret_string = jsonencode({
    for rollbar_access_token_name, rollbar_access_token in data.rollbar_project_access_token.this :
    rollbar_access_token_name => rollbar_access_token.access_token
  })
}
