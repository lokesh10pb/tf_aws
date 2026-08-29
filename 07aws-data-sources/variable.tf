variable "region" {
  description = "Value of region"
  type = string
  default = "us-east-1"
  
}


variable "ami_id" {
      description = "AMI ID for the EC2 instance"
        type        = string
        default = "ami-0332d564d76dbd8d6"

}





variable "ec2_type" {
    description = "Type for the EC2 instance"
    type = string
    default = "t3.nano"

  
}