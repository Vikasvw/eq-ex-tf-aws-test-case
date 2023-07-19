# S3 Backend and State Locking with DynamoDB Table.
# access_key and secret_key are stored in home directory --> ~/.aws/credentials
terraform {
  backend "s3" {
    bucket         = "smx-infra-devops-cross-account-tf-state-us-east-1-dnd"
    key            = "terraform-poc/test-state"
    region         = "us-east-1"
    dynamodb_table = "smx-TerraformStateLock"
    role_arn       = "arn:aws:iam::149648085578:role/SmxTerraformBackendDND"
  }
}
