output "rollbar_project" {
  value = data.rollbar_project.this

  description = "The Rollbar project."
}

output "secretsmanager_secret" {
  value = aws_secretsmanager_secret.this

  description = "The AWS SecretsManager containing the Rollbar project access tokens."
}
