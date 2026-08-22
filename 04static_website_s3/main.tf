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

#create ramdon name for s3 in the end
resource "random_id" "rand_id" {
    byte_length = 8
  
}


provider "aws" {
    region = var.aws_region
  
}

resource "aws_s3_bucket" "webapp-bucket" {
    bucket = "${var.aws_s3_bucket_name}-${random_id.rand_id.hex}"

}



resource "aws_s3_bucket_public_access_block" "webapp_public_access" {
  bucket = aws_s3_bucket.webapp-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}



resource "aws_s3_bucket_policy" "my_bucket_policy" {
  bucket = aws_s3_bucket.webapp-bucket.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.webapp-bucket.arn}/*"
      }
    ]
  })
}



resource "aws_s3_bucket_website_configuration" "webapp_deployment" {
  bucket = aws_s3_bucket.webapp-bucket.id

  index_document {
    suffix = "index.html"
  }


}



#put Object in a bucket
resource "aws_s3_object" "index-html" {
  bucket       = aws_s3_bucket.webapp-bucket.id
  source       = "./index.html"
  key          = "index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "style-css" {
  bucket       = aws_s3_bucket.webapp-bucket.id
  source       = "./style.css"
  key          = "style.css"
  content_type = "text/css"
}
