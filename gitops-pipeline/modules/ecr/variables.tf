variable "repository_name" {
  type        = string
  description = "ECR repository name (unique within account and region)."
}

variable "scan_on_push" {
  type        = bool
  description = "Whether to scan images for vulnerabilities immediately after push."
  default     = true
}

variable "image_tag_mutability" {
  type        = string
  description = "IMMUTABLE will block changing existing tags; MUTABLE allows overwriting."
  default     = "MUTABLE"
}

variable "force_delete" {
  type        = bool
  description = "If true, deleting the repo will automatically delete all images inside."
  default     = true
}

variable "repository_policy" {
  type        = string
  description = "Repository JSON policy."
  default     = null
}
