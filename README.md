# SecretsManager for Rollbar Project Access Tokens

This module creates a SecretsManager and stores the configured Rollbar project access tokens in it.

This is useful in order to load the Rollbar project access tokens into ECS via [`containerDefinitions.secrets.valueFrom`](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/specifying-sensitive-data-secrets.html).

## Usage

```tf
module "secretsmanager-for-rollbar-access-tokens" {
  source  = "babbel/secretsmanager-for-rollbar-access-tokens/aws"
  version = "~> 2.1"

  name_prefix = "example"

  rollbar_tokens = values(rollbar_project_access_token.example)
}
```

In the ECS task definition, you can now define environment variables referencing the SecretsManager:

```tf
resource "aws_ecs_task_definition" "example" {
  ...

  container_definitions = jsonencode([{
    ...

    secrets = [{
      name  = "ROLLBAR_ACCESS_TOKEN"
      value = "${module.secretsmanager-for-rollbar-access-tokens.secretsmanager_secret.arn}:${rollbar_project_access_token.example.name}::"
    }]

    ...
  }])

  ...
}
```

Please also make sure that you grant permissions on the `secretsmanager:GetSecretValue` action for the SecretsManager on the [ECS task execution IAM role](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_execution_IAM_role.html).
