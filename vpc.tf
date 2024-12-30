resource "aws_vpc" "sandbox" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = false

  tags = {
    Name = "vpc-sandbox"
  }
}

resource "aws_subnet" "sandbox" {
  vpc_id                  = aws_vpc.sandbox.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-sandbox"
  }
}

resource "aws_internet_gateway" "sandbox" {
  vpc_id = aws_vpc.sandbox.id

  tags = {
    Name = "igw-sandbox"
  }
}

resource "aws_default_route_table" "sandbox" {
  default_route_table_id = aws_vpc.sandbox.default_route_table_id

  route = []

  tags = {
    Name = "rtb-sandbox-default-disabled"
  }
}

resource "aws_route_table" "sandbox" {
  vpc_id = aws_vpc.sandbox.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sandbox.id
  }

  tags = {
    Name = "rtb-sandbox"
  }
}

resource "aws_route_table_association" "sandbox" {
  subnet_id      = aws_subnet.sandbox.id
  route_table_id = aws_route_table.sandbox.id
}
