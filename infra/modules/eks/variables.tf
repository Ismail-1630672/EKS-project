variable "cluster_name" {
  type        = string
  description = "name of my eks cluster"
}

variable "eks_role_arn" {
}

variable "kubernetes_version" {
  type        = string
  description = "version of kubernetes"
}

variable "public_subnet_id" {
}

variable "private_subnet_id" {
}

variable "vpc_id" {
}

variable "eks_cluster_policy" {
}

variable "eks-node-arn" {
}

variable "node-group-name" {
    type = string 
    description = "name of node group"
}

variable "eks-node-policy" {
}



