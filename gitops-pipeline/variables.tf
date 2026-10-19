variable "github_pat" {
  description = "GitHub Personal Access Token"
  type        = string
  sensitive   = true
}

variable "github_user" {
  description = "GitHub username"
  type        = string
}

variable "github_repo_url" {
  description = "GitHub repository name"
  type        = string
}

variable "jenkins_admin_password" {
  description = "Jenkins administrator password"
  type        = string
  sensitive   = true
}

variable "database_password" {
  description = "RDS or Aurora administrator password"
  type        = string
  sensitive   = true
}
