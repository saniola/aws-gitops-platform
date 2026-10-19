variable "cluster_name" {
  description = "Name of the EKS cluster"
  default     = "example-eks-cluster"
}

variable "desired_size" {
  description = "Desired number of worker nodes"
  default     = 2
}

variable "instance_type" {
  description = "EC2 instance type for the worker nodes"
  default     = "t3.medium"
}

variable "max_size" {
  description = "Maximum number of worker nodes"
  default     = 3
}

variable "min_size" {
  description = "Minimum number of worker nodes"
  default     = 1
}

variable "node_group_name" {
  description = "Name of the node group"
  default     = "example-node-group"
}

variable "region" {
  description = "AWS region for deployment"
  default     = "eu-central-1"
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}
