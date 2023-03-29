# Create a zip archive of your application package
data "archive_file" "langchain_lambda" {
  depends_on  = [null_resource.git_clone_langchain]
  type        = "zip"
  source_dir  = local.project_path
  output_path = "${path.module}/langchain_lambda.zip"
}

data "aws_caller_identity" "current" {}
data "aws_canonical_user_id" "current" {}
