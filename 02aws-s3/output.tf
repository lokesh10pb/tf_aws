output "aws_s3_bucket" {
    value = var.aws_s3_bucket_name
}
output "ramd_id" {
    value = random_id.rand_id.hex
}