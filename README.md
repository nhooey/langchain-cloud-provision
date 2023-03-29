# Terraform Langchain

Terraform scripts to deploy [hwchase17/langchain](https://github.com/hwchase17/langchain) to the cloud.

It currently supports AWS Lambda, but is broken.

# Creating a Terraform user

First ensure your AWS root user, or any user capable of making users and IAM stuff is in `~/.aws/credentials` under the `root` profile:
```text
[root]
aws_access_key_id = <AWS_ACCESS_KEY_ID>
aws_secret_access_key = <AWS_ACCESS_KEY_SECRET>
```

Run Terraform in `bootstrap-terraform-iam-user` to create a user that Terraform will use to manage the AWS lambda jobs:
```bash
cd bootstrap-terraform-iam-user
terraform init
terraform apply

# Get the AWS access key ID for `langchain_lambda`:
bin/terraform-extract-iam-user-access-key-id.sh

# Get the AWS access key secret for `langchain_lambda`:
bin/terraform-extract-iam-user-access-key-secret.sh
```

Add this profile section to `~/.aws/credentials`:
```text
[langchain_lambda]
aws_access_key_id = <AWS_ACCESS_KEY_ID>
aws_secret_access_key = <AWS_ACCESS_KEY_SECRET>
```

Run Terraform in `terraform_langchain` to create the Lambda jobs and all associated resources:
```bash
cd langchain_lambda
terraform init
terraform apply
```
