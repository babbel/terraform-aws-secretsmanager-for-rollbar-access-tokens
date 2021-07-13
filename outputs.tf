output "rollbar_project_name" {
  value = data.rollbar_project.this.name

  description = "The name of the Rollbar project."
}

output "secretsmanager_secret" {
  value = aws_secretsmanager_secret.this

  description = "The AWS SecretsManager containing the Rollbar project access tokens."
}
