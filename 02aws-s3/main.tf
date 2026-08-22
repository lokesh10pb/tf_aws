terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.61.0"
    }    
    random = {
      source  = "hashicorp/random"
      version = "3.9.0"
    }

  }
}


provider "aws" {
    region = var.aws_region
  
}

resource "aws_s3_bucket" "demo-bucket" {
    bucket = "${var.aws_s3_bucket_name}-${random_id.rand_id.hex}"

}

#put Object in a bucket
resource "aws_s3_object" "name" {
bucket = aws_s3_bucket.demo-bucket.id 
source = "./myfile.txt"
key    = "myfile.txt"
}


#create ramdon name for s3 in the end
resource "random_id" "rand_id" {
    byte_length = 8
  
}