resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = var.eks_role_arn
  version  = var.kubernetes_version
  

  

  access_config {
    authentication_mode                         = "API" #users are authenticated and gain entrypoint to eks cluster via API
    bootstrap_cluster_creator_admin_permissions = true  #gives user kubernetes admin access, important for working with helm and also kubernetes manifests
  }

  vpc_config {
    subnet_ids              = flatten([var.public_subnet_id, var.private_subnet_id]) #worker nodes in private, control plane in public
    endpoint_public_access  = true  #enables access of kube API server by the internet
    endpoint_private_access = false #ensures traffic between control plane and worker nodes stays within aws network, very secure

  }

  depends_on = [var.eks_cluster_policy]
}

resource "aws_eks_node_group" "eks_worker_node" {
    cluster_name = aws_eks_cluster.eks_cluster.name 
    node_role_arn = var.eks-node-arn
    node_group_name = var.node-group-name
    subnet_ids = flatten([var.private_subnet_id])

    scaling_config {
      min_size = 3 
      max_size = 5
      desired_size = 3 
    }

    ami_type = "AL2023_x86_64_STANDARD"
    instance_types = ["m7i-flex.large"]

    depends_on = [var.eks-node-policy]
}

#EKS add-ons, these ensure consistent configuration and automated updates
#amazon vpc-CNI, provides networking capabilities to pods
#Core-DNS, provides DNS resolution within cluster
#Kube proxy, maintains network rules on nodes

#First get the latest add on versions
data "aws_eks_addon_version" "vpc-cni" {
    addon_name = "vpc-cni"
    kubernetes_version = aws_eks_cluster.eks_cluster.version 
    most_recent = true 
}

data "aws_eks_addon_version" "core-dns" {
    addon_name = "coredns"
    kubernetes_version = aws_eks_cluster.eks_cluster.version 
    most_recent = true 
}


data "aws_eks_addon_version" "kube-proxy" {
    addon_name = "kube-proxy"
    kubernetes_version = aws_eks_cluster.eks_cluster.version 
    most_recent = true 
}

resource "aws_eks_addon" "vpc-cni" {
    cluster_name = aws_eks_cluster.eks_cluster.name 
    addon_name = "vpc-cni"
    addon_version = data.aws_eks_addon_version.vpc-cni.version

    resolve_conflicts_on_create = "OVERWRITE" #applies when add-on is being created, overwrites existing one
    resolve_conflicts_on_update = "PRESERVE" #applies when add-on is updated
}

resource "aws_eks_addon" "core-dns" {
    cluster_name = aws_eks_cluster.eks_cluster.name 
    addon_name = "coredns"
    addon_version = data.aws_eks_addon_version.core-dns.version  

    resolve_conflicts_on_create = "OVERWRITE"
    resolve_conflicts_on_update = "PRESERVE"

    depends_on = [aws_eks_node_group.eks_worker_node]

    
}



resource "aws_eks_addon" "kube-proxy" {
    cluster_name = aws_eks_cluster.eks_cluster.name 
    addon_name = "kube-proxy"
    addon_version = data.aws_eks_addon_version.kube-proxy.version  

    resolve_conflicts_on_create = "OVERWRITE"
    resolve_conflicts_on_update = "PRESERVE"

    
}