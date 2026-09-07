variable "aws_ec2_type" {
  description = "What type ec2 you want"
  type        = string


  # validation {
  #   condition     = var.aws_ec2_type == "t2.nano" || var.aws_ec2_type == "t3.micro"
  #   error_message = "aws_ec2_type must be either t2.nano or t3.micro."
  # }

  default = "t2.nano"
}

variable "ec2_config" {
  type = object({
    vol_size     = number
    vol_type     = string
    ec2_ami      = string

  })
  

  default = {
    vol_size     = 20
    vol_type     = "gp3"
    ec2_ami      = "ami-0332d564d76dbd8d6"
    
  }
}

# Map Variable
variable "Add_tags" {
  type = map(string)

  default = {
    ENV = "DEV"
  }
}
