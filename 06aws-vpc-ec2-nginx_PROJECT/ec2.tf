
resource "aws_instance" "NginexWebServer" {
    ami = var.ami_id
    instance_type = var.ec2_type
    subnet_id = aws_subnet.public_subnet-1a.id
    vpc_security_group_ids = [aws_security_group.nginx-web-sg.id]
    user_data = file("install-nginx.sh") 
    associate_public_ip_address = true
    
  tags = {
    Name = "NginexWebServer"
  }

  root_block_device {
     volume_size = 10
    volume_type = "gp3"
  }
}



resource "aws_eip" "Elastic-ip" {
  instance = aws_instance.NginexWebServer.id
  domain   = "vpc"
}