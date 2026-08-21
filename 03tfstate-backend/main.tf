terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.61.0"
    }
  }
  backend "s3" {
    bucket = "demo-oidc-1"
    key = "backend.tfstate"
    region = "us-east-1"
    
  }
}

provider "aws" {
region = var.region
}

resource "aws_instance" "my_server" {
    ami = var.ami_id
    instance_type = var.ec2_type
  tags = {
    Name = "SampleServer"
  }

  root_block_device {
     volume_size = 10
    volume_type = "gp3"
  }
}