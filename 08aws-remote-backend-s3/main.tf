

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



#create bucket
resource "aws_s3_bucket" "s3_bucket" {
  bucket = "config-31d3-tf-state"
}