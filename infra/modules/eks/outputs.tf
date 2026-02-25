output "eks-cluster_name" {
  description = "name of eks cluster"
  value       = aws_eks_cluster.eks_cluster.name
}

output "vpc-cni-version" {
    description = "version of addon for vpc-cni"
    value = data.aws_eks_addon_version.vpc-cni.version 
}

output "core-dns-version" {
    description = "version of addon for core-dns"
    value = data.aws_eks_addon_version.core-dns.version 
}

output "kube-proxy-version" {
    description = "version of addon for kube-proxy"
    value = data.aws_eks_addon_version.kube-proxy.version 
}