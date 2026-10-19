output "ecr_name" {
  description = "ECR repository URL"
  value       = aws_ecr_repository.this.repository_url
}
