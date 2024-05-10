# Define the VPC
resource "aws_vpc" "lms_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "LMSOncloudVPC"
  }
}

# Create a public subnet
resource "aws_subnet" "lms_public_subnet" {
  vpc_id            = aws_vpc.lms_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "LMSOncloudPublicSubnet"
  }
}

# Create a private subnet
resource "aws_subnet" "lms_private_subnet" {
  vpc_id            = aws_vpc.lms_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "LMSOncloudPrivateSubnet"
  }
}

# Internet Gateway for the VPC
resource "aws_internet_gateway" "lms_igw" {
  vpc_id = aws_vpc.lms_vpc.id
  tags = {
    Name = "LMSOncloudIGW"
  }
}

# Route Table for Public Subnet (Including Default Route)
resource "aws_route_table" "lms_public_route_table" {
  vpc_id = aws_vpc.lms_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lms_igw.id
  }

  tags = {
    Name = "LMSOncloudPublicRouteTable"
  }
}

# Associate Public Subnet with Route Table
resource "aws_route_table_association" "lms_public_rta" {
  subnet_id      = aws_subnet.lms_public_subnet.id
  route_table_id = aws_route_table.lms_public_route_table.id
}

# Route Table for Private Subnet (No Default Route to IGW)
resource "aws_route_table" "lms_private_route_table" {
  vpc_id = aws_vpc.lms_vpc.id

  tags = {
    Name = "LMSOncloudPrivateRouteTable"
  }
}

# Associate Private Subnet with Route Table
resource "aws_route_table_association" "lms_private_rta" {
  subnet_id      = aws_subnet.lms_private_subnet.id
  route_table_id = aws_route_table.lms_private_route_table.id
}
