terraform {
  required_version = ">= 1.4.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.67.0"
    }
  }
}

# Configure the AWS Provider
# access_key and secret_key are stored in home directory --> ~/.aws/credentials
provider "aws" {
  region = var.aws_region
  assume_role {
    role_arn     = var.workspace_iam_roles[terraform.workspace]
    session_name = "terraform_sts"
  }
  default_tags {
    tags = {
      "ProvisionedBy" = "Terraform"
      "Environment"   = var.Environment
    }
  }
}
