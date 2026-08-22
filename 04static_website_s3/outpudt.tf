output "website_url" {
  value = aws_s3_bucket_website_configuration.webapp_deployment.website_endpoint
}