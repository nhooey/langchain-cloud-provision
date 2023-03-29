provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile_root
}

resource "aws_iam_user" "terraform" {
  name = var.terraform_iam_user_name
}

resource "aws_iam_access_key" "terraform" {
  user = aws_iam_user.terraform.name
}

resource "aws_iam_policy" "terraform_policy" {
  name   = "${aws_iam_user.terraform.name}_policy"
  policy = data.aws_iam_policy_document.terraform_policy.json
}

data "aws_iam_policy_document" "terraform_policy" {
  statement {
    effect  = "Allow"
    actions = [
      "iam:AttachRolePolicy",
      "iam:CreatePolicy",
      "iam:CreateRole",
      "iam:DeleteRole",
      "iam:GetRole",
      "iam:ListAttachedRolePolicies",
      "iam:ListInstanceProfilesForRole",
      "iam:ListRolePolicies",
      "lambda:CreateFunction",
      "lambda:UpdateFunctionCode",
      "lambda:UpdateFunctionConfiguration",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "s3:*",
      "s3:CreateBucket",
      "s3:GetBucketAcl",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:ListBuckets",
      "s3:ListRegionalBuckets",
      "s3:PutObject",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_user_policy_attachment" "terraform_policy_attachment" {
  user       = aws_iam_user.terraform.name
  policy_arn = aws_iam_policy.terraform_policy.arn
}
