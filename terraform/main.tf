terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  backend "s3" {
    bucket         = "resume.chadgud.dev-terraform-state"
    key            = "resume-site-terraform/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "resume-site-terraform-locks"
    encrypt        = true
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

locals {
  mime_types = jsondecode(file("mime-types.json"))
}
