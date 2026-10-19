output "bucket_name" {
  description = "Name of the S3 bucket for state files"
  value       = module.s3_backend.bucket_name
}

output "table_name" {
  description = "Name of the DynamoDB table for state locking"
  value       = module.s3_backend.table_name
}

