terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.61.0"
    }
  }
}


provider "aws" {
  region = "us-east-1"
}


locals {
  project = "project-01"

}

resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${local.project}-vpc"
  }

}




#create public sunet
resource "aws_subnet" "public_subnet" {
  count = 3
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.${count.index + 1}.0/24"
  availability_zone = var.availability_zones[count.index]
  tags = {
   Name = "${local.project}-public-subnet-${var.availability_zones[count.index]}"
  }
}
#create private sunet

resource "aws_subnet" "private_subnet" {
  count = 3
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.${count.index + 4}.0/24"
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = "${local.project}-private-subnet-${var.availability_zones[count.index]}"
  }
}

#create 6 ec2 

# resource "aws_instance" "main" {
#   ami =  "ami-0332d564d76dbd8d6"
#   subnet_id = element(aws_subnet.public_subnet[*].id, count.index %  length(aws_subnet.public_subnet))
#   instance_type = "t3.nano"
#   count = 6
#   tags = {
#      Name = "${local.project}web-server${count.index + 1 }"
#   }
# }

#Pace diff type ec2 in each subnent
