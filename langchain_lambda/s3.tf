resource "aws_s3_bucket" "langchain_lambda" {
  bucket = "aws-lambda-langchain-${local.aws_account_id_sha1}"

  tags = {
    Name        = "aws-lambda-langchain"
    Environment = "production"
  }
}

resource "aws_s3_bucket_acl" "langchain_lambda" {
  bucket = aws_s3_bucket.langchain_lambda.id
  access_control_policy {
    grant {
      grantee {
        id   = data.aws_canonical_user_id.current.id
        type = "CanonicalUser"
      }
      permission = "READ"
    }

    grant {
      grantee {
        type = "Group"
        uri  = "http://acs.amazonaws.com/groups/s3/LogDelivery"
      }
      permission = "READ_ACP"
    }

    owner {
      id = data.aws_canonical_user_id.current.id
    }
  }
}

# Upload the application package to an S3 bucket
resource "aws_s3_object" "langchain_lambda" {
  depends_on = [data.archive_file.langchain_lambda]
  bucket     = aws_s3_bucket.langchain_lambda.id
  key        = "lambda.zip"
  source     = data.archive_file.langchain_lambda.output_path
  etag       = data.archive_file.langchain_lambda.output_base64sha256
}
