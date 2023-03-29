# Create an IAM role for the AWS Lambda function
resource "aws_iam_role" "langchain_lambda" {
  name = "langchain_lambda"

  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
      {
        "Effect" = "Allow",
        "Action" = ["logs:*"],
        "Resource" : "arn:aws:logs:*:*:*"
      },
      {
        "Effect"   = "Allow",
        "Action"   = ["s3:*"],
        "Resource" = "arn:aws:s3:::*"
      },
    ]
  })
}

# Attach an IAM policy to the IAM role
resource "aws_iam_role_policy_attachment" "langchain_lambda" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.langchain_lambda.name
}
