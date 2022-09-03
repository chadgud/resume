terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "resume-site-terraform-state" {
  bucket = "resume.chadgud.dev-terraform-state"
}

resource "aws_s3_bucket_versioning" "resume-site-s3-bucket-versioning" {
  bucket = aws_s3_bucket.resume-site-terraform-state.bucket
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "resume-site-s3-encryption" {
  bucket = aws_s3_bucket.resume-site-terraform-state.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "resume-site-terraform-locks" {
  name         = "resume-site-terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
