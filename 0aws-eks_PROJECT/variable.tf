variable "availability_zones" {
  description = "Eneter availabilty zones"
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "eks_version" {
  description = "Kubernetes version for EKS cluster"
  type        = string
  default     = "1.33"
}

variable "eks_node_instance_type" {
  description = "EC2 instance type for EKS worker nodes"
  type        = string
  default     = "t3.medium"
}