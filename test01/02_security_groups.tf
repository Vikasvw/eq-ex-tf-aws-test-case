# Create security group for EC2 instance
resource "aws_security_group" "test_sg" {
  name        = "test-sg"
  description = "Allow SSH access"
  vpc_id      = aws_vpc.test_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr_block}"]
  }
}
