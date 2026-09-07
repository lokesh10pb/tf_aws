resource "aws_instance" "my_server" {
  ami           = var.ami_id
  instance_type = var.ec2_type

  tags = {
    Name = "SampleServer"
  }

  root_block_device {
    volume_size = var.ec2_config.vol_size
    volume_type =  var.ec2_config.vol_type
  }
}

