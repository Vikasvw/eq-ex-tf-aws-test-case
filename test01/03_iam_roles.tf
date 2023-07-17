# Create IAM Role to attach to EC2 instance
resource "aws_iam_role" "test_ec2_instance_role" {
  name_prefix        = "${var.test_ec2_name_prefix}-instance-role"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole", 
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
EOF
  tags = {
    Name = "${var.test_ec2_name_prefix}-instance-role"
  }
}

resource "aws_iam_role_policy" "test_ec2_instance_policy" {
  name_prefix = "${var.test_ec2_name_prefix}-instance-policy"
  role        = aws_iam_role.test_ec2_instance_role.id
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "s3:ListBucket",
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
