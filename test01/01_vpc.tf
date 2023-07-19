# Create VPC
resource "aws_vpc" "test_vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = var.vpc_tenancy

  tags = {
    Name = "${var.Environment}_vpc"
  }
}

# Create public subnet
resource "aws_subnet" "test_vpc_subnet_public" {
  vpc_id            = aws_vpc.test_vpc.id
  cidr_block        = var.vpc_subnet_public_cidr_block
  availability_zone = var.vpc_subnet_public_az
  tags = {
    Name = "${var.Environment}_vpc_subnet_public"
  }
}

# Create private subnet
resource "aws_subnet" "test_vpc_subnet_private" {
  vpc_id            = aws_vpc.test_vpc.id
  cidr_block        = var.vpc_subnet_private_cidr_block
  availability_zone = var.vpc_subnet_private_az
  tags = {
    Name = "${var.Environment}_vpc_subnet_private"
  }
}

# Create internet gateway
resource "aws_internet_gateway" "test_igw" {
  vpc_id = aws_vpc.test_vpc.id
  tags = {
    Name = "${var.Environment}_vpc_igw"
  }
}

# Create NAT gateway
resource "aws_nat_gateway" "test_ngw" {
  allocation_id     = aws_eip.my_eip.id
  subnet_id         = aws_subnet.test_vpc_subnet_public.id
  connectivity_type = "public"
  tags = {
    Name = "${var.Environment}_vpc_subnet_public_ngw"
  }
}

# Allocate EIP for NAT gateway
resource "aws_eip" "my_eip" {
  tags = {
    Name = "my_eip"
  }
}

# Create RT
resource "aws_route_table" "test_vpc_pub_rt" {
  vpc_id = aws_vpc.test_vpc.id

  tags = {
    Name = "${var.Environment}_vpc_pub_rt"
  }
}

resource "aws_route_table" "test_vpc_pvt_rt" {
  vpc_id = aws_vpc.test_vpc.id

  tags = {
    Name = "${var.Environment}_vpc_pvt_rt"
  }
}

# RT Associations
resource "aws_route_table_association" "pub_subnet" {
  subnet_id      = aws_subnet.test_vpc_subnet_public.id
  route_table_id = aws_route_table.test_vpc_pub_rt.id
}

resource "aws_route_table_association" "pvt_subnet" {
  subnet_id      = aws_subnet.test_vpc_subnet_private.id
  route_table_id = aws_route_table.test_vpc_pvt_rt.id
}

# Add routes to the Route Table
resource "aws_route" "pub_rt" {
  route_table_id         = aws_route_table.test_vpc_pub_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.test_igw.id
}

resource "aws_route" "pvt_rt" {
  route_table_id         = aws_route_table.test_vpc_pvt_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.test_ngw.id
}

