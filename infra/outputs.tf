output "vpc_id" {
  value = module.vpc.vpc_id
}

output "gateway_id" {
  value = module.vpc.gateway_id
}

output "public_subnet_id" {
  value = module.vpc.public_subnet_id
}

output "elastic_ip_id" {
  value = module.vpc.elastic_ip_id
}

output "ngw_id" {
  value = module.vpc.ngw_id
}

output "private_route_table_id" {
  value = module.vpc.private_route_table_id
}

output "private_subnet_id" {
  value = module.vpc.private_subnet_id
}

output "security_group_id" {
  value = module.vpc.security_group_id
}

output "eks-cluster-role" {
  value = module.IAM.eks-cluster-role
}

output "eks-role-arn" {
  value = module.IAM.eks-role-arn
}

output "eks-node-role" {
  value = module.IAM.eks-node-role
}

output "eks-node-arn" {
  value = module.IAM.eks-node-arn
}

output "cert-manager-pod-identity-role-name" {
  value = module.IAM.cert-manager-pod-identity-role-name
}

output "cert-policy-arn" {
  value = module.IAM.cert-policy-arn
}

output "cert-manager-role-arn" {
  value = module.IAM.cert-manager-role-arn
}

output "external-dns-pod-identity-role-name" {
  value = module.IAM.external-dns-pod-identity-role-name
}

output "external-dns-policy-arn" {
  value = module.IAM.external-dns-policy-arn
}

output "external-dns-role-arn" {
  value = module.IAM.external-dns-role-arn
}

output "eks-cluster-policy" {
  value = module.IAM.eks-cluster-policy
}

output "eks-cluster-name" {
  value = module.eks.eks-cluster-name
}

output "eks-node-policy" {
  value = module.IAM.eks-node-policy
}

output "vpc-cni-version" {
  value = module.eks.vpc-cni-version
}

output "core-dns-version" {
  value = module.eks.core-dns-version
}

output "kube-proxy-version" {
  value = module.eks.kube-proxy-version
}

output "ebs-csi-version" {
  value = module.eks.ebs-csi-version
}

output "pod-identity-agent-version" {
  value = module.eks.pod-identity-agent-version
}
  
  










