terraform {
  backend "s3" {
    bucket = "config-31d3-tf-state"
    region = "us-east-1"
    key = "s3_backend/terraform.tfstate"
    use_lockfile = true

  }
}

