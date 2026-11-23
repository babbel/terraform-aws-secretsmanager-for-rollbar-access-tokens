# SecretsManager for Rollbar Project Access Tokens

This module creates a SecretsManager and stores the configured Rollbar project access tokens in it.

This is useful in order to load the Rollbar project access tokens into ECS via [`containerDefinitions.secrets.valueFrom`](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/specifying-sensitive-data-secrets.html).

## Usage

```tf
module "secretsmanager-for-rollbar-access-tokens" {
  source  = "babbel/secretsmanager-for-rollbar-access-tokens/aws"
  version = "~> 4.0"

  name_prefix = "example"

  rollbar_tokens = values(rollbar_project_access_token.example)
}
```

The secret value is written with the write-only argument `secret_string_wo`, so the tokens are not stored in the state of the secret version, and plans do not read the secret value. Because Terraform cannot compare a write-only value with the stored secret, a change of `rollbar_tokens` is only written when `secret_string_wo_version` changes. Increase it whenever you add, remove or replace a token:

```tf
module "secretsmanager-for-rollbar-access-tokens" {
  ...

  secret_string_wo_version = 2
}
```

The tokens themselves are still stored in the state of the `rollbar_project_access_token` resources, because the Rollbar provider has no write-only or ephemeral alternative.

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
