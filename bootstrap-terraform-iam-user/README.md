# Create AWS IAM user: `terraform_langchain`

```bash
terraform plan -out terraform_plan.txt
# Confirm that changes are okay

# Apply changes from the plan formed before
terraform apply terraform_plan.txt

# Display the keys
terraform state pull | jq '.resources[] | select(.type == "aws_iam_access_key") | .instances[0].attribute
s'


```
