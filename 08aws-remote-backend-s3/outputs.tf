output "ec2_pubic_ip" {
value = aws_instance.my_server.public_ip
}

output "ec2_private_ip" {
value = aws_instance.my_server.private_ip
}