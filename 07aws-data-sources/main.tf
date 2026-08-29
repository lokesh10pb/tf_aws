terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.61.0"
    }
  }
}

provider "aws" {
region = var.region
}


data "aws_ami" "name"{
  most_recent = true
  owners = [ "amazon" ]
  region = var.region
  

}


output "aws_ami" {
value = data.aws_ami.name

}

resource "aws_instance" "my_server" {
    ami = data.aws_ami.name.id
    instance_type = var.ec2_type
  tags = {
    Name = "MyWebServer"
  }

  root_block_device {
     volume_size = 10
    volume_type = "gp3"
  }
}
