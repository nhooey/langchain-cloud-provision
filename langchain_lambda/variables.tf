variable "aws_region" {
  description = "The AWS region to use"
  default     = "us-east-1"
}

variable "aws_profile_terraform_langchain" {
  description = "The AWS profile alias to use for managing AWS Lambda jobs"
  default     = "terraform_langchain"
}
