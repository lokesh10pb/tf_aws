
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.61.0"
    }
  }
}

locals {
  ownerc = "ABC"
  Name = "Sever"
}



provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "my_server" {
  disable_api_termination = true

  ami           = var.ec2_config.ec2_ami
  instance_type = var.aws_ec2_type
  
  tags = merge(var.Add_tags, {
    Name = "Web_server"
    Name = local.Name
  })

  root_block_device {
    volume_size = var.ec2_config.vol_size
    volume_type = var.ec2_config.vol_type
  }
}


