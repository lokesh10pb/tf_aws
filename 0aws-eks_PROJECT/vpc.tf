# Main VPC
resource "aws_vpc" "my_proj_vpc" {
  cidr_block = "10.0.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${local.project}-vpc"
  }
}


# Internet gateway for public subnets
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_proj_vpc.id

  tags = {
    Name = "${local.project}-igw"
  }
}


# Public subnets - one per AZ
resource "aws_subnet" "public" {
  count = length(var.availability_zones)

  vpc_id                  = aws_vpc.my_proj_vpc.id
  cidr_block              = "10.0.${count.index + 1}.0/24"
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name                     = "${local.project}-public-subnet-${var.availability_zones[count.index]}"
    "kubernetes.io/role/elb" = "1"
  }
}


# Private subnets - one per AZ
resource "aws_subnet" "private" {
  count = length(var.availability_zones)

  vpc_id            = aws_vpc.my_proj_vpc.id
  cidr_block        = "10.0.${count.index + 4}.0/24"
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name                              = "${local.project}-private-subnet-${var.availability_zones[count.index]}"
    "kubernetes.io/role/internal-elb" = "1"
  }
}


# Public route table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_proj_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${local.project}-public-route"
  }
}


# Attach all public subnets to public route table
resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public_rt.id
}


# Elastic IP for NAT gateway
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "${local.project}-nat-eip"
  }
}


# Single NAT gateway for dev/staging
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  depends_on = [
    aws_internet_gateway.igw
  ]

  tags = {
    Name = "${local.project}-nat"
  }
}


# Private route table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.my_proj_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "${local.project}-private-route"
  }
}


# Attach all private subnets to private route table
resource "aws_route_table_association" "private" {
  count = length(aws_subnet.private)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private_rt.id
}


