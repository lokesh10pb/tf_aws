output "aws-ec2_pubic_ip" {
   value = aws_instance.NginexWebServer.public_ip
   

}

output "aws-ec2_private_ip" {
   value = aws_instance.NginexWebServer.private_ip
   

}