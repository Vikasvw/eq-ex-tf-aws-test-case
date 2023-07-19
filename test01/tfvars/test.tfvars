workspace_iam_roles = {
  test = "arn:aws:iam::149648085578:role/SmxTerraformDND"  # Update the IAM role ARN
  default = "arn:aws:iam::149648085578:role/SmxTerraformDND"
}
Environment = "test"
aws_region = "us-east-1"

# VPC variables
vpc_cidr_block = "172.20.0.0/16"
vpc_tenancy    = "default"

# VPC Public Subnet Variables
vpc_subnet_public_cidr_block  = "172.20.10.0/24"
vpc_subnet_public_az  = "us-east-1a"

# # VPC Private Subnet Variables
vpc_subnet_private_cidr_block = "172.20.20.0/24"
vpc_subnet_private_az = "us-east-1a"

# EC2 Instance variables
test_ec2_count = 1
test_ec2_name_prefix = "test-ec2"
test_ec2_ami_id = "ami-04823729c75214919"     # Update the AMI ID. This is tested on Amazon Linux 2 AMI.
test_ec2_instance_type = "t2.micro"
key_pair_name = "VPC-Key02"        # Also make sure this Key is precreated.
