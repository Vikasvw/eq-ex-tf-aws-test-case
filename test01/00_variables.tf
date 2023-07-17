variable "workspace_iam_roles" {
  type = map(any)
  description = "Workspacewise i.e. environmentwise IAM Role ARN"  
}

variable "Environment" {
  type = string
  description = "Environment name"
}

variable "aws_region" {
  type = string
  description = "aws_region"
  default = "us-east-1"
}

variable "vpc_cidr_block" {
  type = string
  description = "vpc_cidr_block"
}

variable "vpc_tenancy" {
  type = string
  description = "vpc_tenancy"
}

variable "vpc_subnet_public_cidr_block" {
  type = string
  description = "vpc_subnet_public_cidr_block"
}

variable "vpc_subnet_public_az" {
  type = string
  description = "vpc_subnet_public_az"
}

variable "vpc_subnet_private_cidr_block" {
  type = string
  description = "vpc_subnet_private_cidr_block"
}

variable "vpc_subnet_private_az" {
  type = string
  description = "vpc_subnet_private_az"
}

variable "test_ec2_count" {
  type = number
  description = "test_ec2_count"
}

variable "test_ec2_name_prefix" {
  type = string
  description = "test_ec2_name_prefix"
}

variable "test_ec2_ami_id" {
  type = string
  description = "test_ec2_ami_id"
}

variable "test_ec2_instance_type" {
  type = string
  description = "test_ec2_instance_type"
}

variable "key_pair_name" {
  type = string
  description = "key_pair_name"
}
