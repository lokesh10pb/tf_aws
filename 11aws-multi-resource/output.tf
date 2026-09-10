output "aws_subnet_name" {
    value = aws_subnet.public_subnet[*].id
  
}
