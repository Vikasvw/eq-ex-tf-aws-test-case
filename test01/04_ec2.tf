# Create EC2 Instance and install jenkins and ansible-
resource "aws_iam_instance_profile" "test_ec2_instance_profile" {
  name = "${var.test_ec2_name_prefix}-instance-profile"
  role = aws_iam_role.test_ec2_instance_role.name
  tags = {
    Name = "${var.test_ec2_name_prefix}-instance-profile"
  }
}

# Create EC2 Instance. Its Assumed that key pair is already created
module "test_ec2" {
  count   = var.test_ec2_count
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.2.1"

  name                   = "${var.test_ec2_name_prefix}-${count.index}"
  ami                    = var.test_ec2_ami_id
  instance_type          = var.test_ec2_instance_type
  key_name               = var.key_pair_name
  subnet_id              = aws_subnet.test_vpc_subnet_private.id
  vpc_security_group_ids = [aws_security_group.test_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.test_ec2_instance_profile.name
  user_data              = <<-EOF
    #!/bin/bash
  
    sudo yum update -y
    sudo amazon-linux-extras install -y epel
    sudo amazon-linux-extras install -y java-openjdk11
  
    # Install Jenkins
    sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
    sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
    sudo yum -y upgrade
  
    # Add required dependencies for the jenkins package
    sudo yum install -y jenkins
    sudo systemctl daemon-reload
    sudo systemctl enable jenkins
    sudo systemctl start jenkins
  
    # Install Ansible
    sudo yum install -y ansible

  EOF

  tags = {
    Name = "${var.test_ec2_name_prefix}-${count.index}"
  }
}
