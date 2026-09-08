#create bucket
resource "aws_s3_bucket" "s3_bucket" {
  bucket = "config-31d3-tf-state"
}

terraform {
  backend "s3" {
    bucket = "config-31d3-tf-state"
    region = "us-east-1"
    key = "s3_backend/terraform.tfstate"
    use_lockfile = true

  }
}

