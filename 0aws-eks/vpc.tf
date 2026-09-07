resource "aws_vpc" "my_vpc" {

  cidr_block = local.vpc_cidr

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${local.name}-vpc"
  }

}


# Creating public subnets

resource "aws_subnet" "public_1" {

  vpc_id = aws_vpc.my_vpc.id

  cidr_block = "10.0.1.0/24"

  availability_zone = "us-east-1a"

  map_public_ip_on_launch = true

  tags = {
    Name = "${local.name}-public-1"
  }

}


resource "aws_subnet" "public_2" {

  vpc_id = aws_vpc.my_vpc.id

  cidr_block = "10.0.2.0/24"

  availability_zone = "us-east-1b"

  map_public_ip_on_launch = true

  tags = {
    Name = "${local.name}-public-2"
  }

}


resource "aws_subnet" "public_3" {

  vpc_id = aws_vpc.my_vpc.id

  cidr_block = "10.0.3.0/24"

  availability_zone = "us-east-1c"

  map_public_ip_on_launch = true

  tags = {
    Name = "${local.name}-public-3"
  }

}


# Creating private subnets

resource "aws_subnet" "private_1" {

  vpc_id = aws_vpc.my_vpc.id

  cidr_block = "10.0.4.0/24"

  availability_zone = "us-east-1a"

  map_public_ip_on_launch = false

  tags = {
    Name = "${local.name}-private-1"
  }

}


resource "aws_subnet" "private_2" {

  vpc_id = aws_vpc.my_vpc.id

  cidr_block = "10.0.5.0/24"

  availability_zone = "us-east-1b"

  map_public_ip_on_launch = false

  tags = {
    Name = "${local.name}-private-2"
  }

}


resource "aws_subnet" "private_3" {

  vpc_id = aws_vpc.my_vpc.id

  cidr_block = "10.0.6.0/24"

  availability_zone = "us-east-1c"

  map_public_ip_on_launch = false

  tags = {
    Name = "${local.name}-private-3"
  }

}

#internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

}

#creating Nat
resource "aws_eip" "nat_eip" {

  domain = "vpc"

  tags = {
    Name = "${local.name}-nat-eip"
  }

}


resource "aws_nat_gateway" "my_nat" {

  allocation_id = aws_eip.nat_eip.id

  subnet_id = aws_subnet.public_1.id

  tags = {
    Name = "${local.name}-nat"
  }

  depends_on = [aws_internet_gateway.my_igw]

}

#creatign public and private route 

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }


  tags = {
    Name = "public-route-table"
  }
}




resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "private-route-table"
  }
}
