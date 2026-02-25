variable "vpc_cidr" {
  type        = string
  description = "IP range for my vpc"
  default     = "10.0.0.0/16"
}

variable "project_name" {
  type        = string
  description = "name of my project"
  default     = "EKS-project"
}

variable "az_count" {
  type        = number
  description = "number of availability zones"
  default     = 2
}

variable "sg_name" {
  type        = string
  description = "name of security group"
  default     = "eks-security-group"
}

variable "cluster_name" {
  type        = string
  description = "name of eks cluster"
  default     = "ismail-eks-cluster"
}

variable "kubernetes_version" {
  type        = string
  description = "version of kubernetes"
  default     = "1.34"
}

variable "node-group-name" {
  type        = string
  description = "name of node group"
  default     = "ismail-node-group"
}


