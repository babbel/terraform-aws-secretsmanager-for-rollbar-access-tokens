output "secretsmanager_secret" {
  value = aws_secretsmanager_secret.this

  description = "The AWS SecretsManager containing the Rollbar project access tokens."
}
