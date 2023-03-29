variable "aws_region" {
  description = "The AWS region to use"
  default     = "us-east-1"
}

variable "aws_profile_root" {
  description = "The AWS profile alias to use for creating the Terraform IAM user."
  type        = string
  default     = "root"
}

variable "terraform_iam_user_name" {
  description = "The name of the Terraform IAM user"
  default     = "terraform_langchain"
}
