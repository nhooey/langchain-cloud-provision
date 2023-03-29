provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile_terraform_langchain
}

locals {
  project_path = "${path.module}/langchain"
  aws_account_id_sha1 = sha1(data.aws_caller_identity.current.account_id)
}

resource "null_resource" "git_clone_langchain" {
  triggers = {
    random_string = "foo"
  }

  provisioner "local-exec" {
    command = "git clone https://github.com/hwchase17/langchain.git ${local.project_path}"
  }
}

# Create an AWS Lambda function
resource "aws_lambda_function" "langchain" {
  filename         = aws_s3_object.langchain_lambda.id
  function_name    = "langchain"
  role             = aws_iam_role.langchain_lambda.arn
  handler          = "index.handler"
  source_code_hash = data.archive_file.langchain_lambda.output_base64sha256
  runtime          = "python3.9"
  timeout          = 600
  memory_size      = 128
}
