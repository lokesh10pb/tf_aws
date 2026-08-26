terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.61.0"
    }
  }
}


resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my-pc"
  }

}

#Public subnet 
resource "aws_subnet" "public_subnet-1a" {
  vpc_id            = aws_vpc.my-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "public_subnet-us-east-1a"
  }
}

resource "aws_subnet" "public_subnet-1b" {
  vpc_id            = aws_vpc.my-vpc.id
  availability_zone = "us-east-1b"
  cidr_block        = "10.0.2.0/24"
  tags = {
    Name = "public_subnet-us-east-1b"
  }
}

resource "aws_subnet" "public_subnet-1c" {
  vpc_id            = aws_vpc.my-vpc.id
  availability_zone = "us-east-1c"
  cidr_block        = "10.0.3.0/24"
  tags = {
    Name = "public_subnet-us-east-1c"
  }
}
resource "aws_subnet" "private_subnet-1a" {
  vpc_id            = aws_vpc.my-vpc.id
  availability_zone = "us-east-1a"
  cidr_block        = "10.0.4.0/24"
  tags = {
    Name = "priavte_subnet-us-east-1a"
  }
}

resource "aws_subnet" "private_subnet-1b" {
  vpc_id            = aws_vpc.my-vpc.id
  availability_zone = "us-east-1b"
  cidr_block        = "10.0.5.0/24"
  tags = {
    Name = "private_subnet-us-east-1b"
  }
}
resource "aws_subnet" "private_subnet-1c" {
  vpc_id            = aws_vpc.my-vpc.id
  availability_zone = "us-east-1c"
  cidr_block        = "10.0.6.0/24"
  tags = {
    Name = "private_subnet-us-east-1c"
  }
}



#Internate Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "my-igw"
  }

}



#Route Table  for public subnet 
resource "aws_route_table" "my-public-route" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id

  }
  tags = {
    Name = "my-public-route"
  }

}

#Private Route
resource "aws_route_table" "private-route" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = "my-private-route"
  }

}

#Route Assocation with public  subnets 
resource "aws_route_table_association" "public_subnet_1a" {
    subnet_id = aws_subnet.public_subnet-1a.id
    route_table_id = aws_route_table.my-public-route.id
  
}
resource "aws_route_table_association" "public_subnet_1b" {
    subnet_id = aws_subnet.public_subnet-1b.id
    route_table_id = aws_route_table.my-public-route.id
  
}
resource "aws_route_table_association" "public_subnet_1c" {
    subnet_id = aws_subnet.public_subnet-1c.id
    route_table_id = aws_route_table.my-public-route.id
  
}
#Route Assocation with public  subnets 
# Route Association with private subnets

resource "aws_route_table_association" "private_subnet_1a" {
  subnet_id      = aws_subnet.private_subnet-1a.id
  route_table_id = aws_route_table.private-route.id
}

resource "aws_route_table_association" "private_subnet_1b" {
  subnet_id      = aws_subnet.private_subnet-1b.id
  route_table_id = aws_route_table.private-route.id
}

resource "aws_route_table_association" "private_subnet_1c" {
  subnet_id      = aws_subnet.private_subnet-1c.id
  route_table_id = aws_route_table.private-route.id
}
