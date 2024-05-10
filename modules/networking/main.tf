resource "aws_vpc" "lms_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "LMSOncloudVPC"
  }
}

resource "aws_subnet" "lms_subnet" {
  vpc_id            = aws_vpc.lms_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "LMSOncloudSubnet"
  }
}

resource "aws_internet_gateway" "lms_igw" {
  vpc_id = aws_vpc.lms_vpc.id

  tags = {
    Name = "LMSOncloudIGW"
  }
}

resource "aws_route_table" "lms_route_table" {
  vpc_id = aws_vpc.lms_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lms_igw.id
  }

  tags = {
    Name = "LMSOncloudRouteTable"
  }
}

resource "aws_route_table_association" "lms_rta" {
  subnet_id      = aws_subnet.lms_subnet.id
  route_table_id = aws_route_table.lms_route_table.id
}
