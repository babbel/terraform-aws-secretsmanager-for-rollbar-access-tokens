resource "aws_secretsmanager_secret" "this" {
  name        = "${var.name_prefix}.rollbar_access_tokens"
  description = "Secret value is managed via Terraform"

  tags = var.default_tags
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id = aws_secretsmanager_secret.this.arn

  secret_string = jsonencode({
    for rollbar_token in var.rollbar_tokens :
    rollbar_token.name => rollbar_token.access_token
  })
}
