# S3 Backend and State Locking with DynamoDB Table.
# access_key and secret_key are stored in home directory --> ~/.aws/credentials
terraform {
  backend "s3" {
    bucket         = "test-terraform-tf-state-bucket"
    key            = "terraform-poc/test-state"
    region         = "us-east-1"
    dynamodb_table = "test-tf-state-lock-dynamodb-table"
    role_arn       = "arn:aws:iam::111111111111:role/test-terraform-role"
  }
}
