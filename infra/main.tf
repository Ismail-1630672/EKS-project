module "vpc" {
  source       = "./modules/vpc"
  vpc_cidr     = var.vpc_cidr
  project_name = var.project_name
  az_count     = var.az_count
  sg_name      = var.sg_name
}

module "IAM" {
  source           = "./modules/IAM"
  eks_cluster_name = module.eks.eks-cluster_name
}

module "eks" {
  source             = "./modules/eks"
  cluster_name       = var.cluster_name
  eks_role_arn       = module.IAM.eks-role-arn
  kubernetes_version = var.kubernetes_version
  public_subnet_id   = module.vpc.public_subnet_id
  private_subnet_id  = module.vpc.private_subnet_id
  vpc_id             = module.vpc.vpc_id
  eks_cluster_policy = module.IAM.eks-cluster-policy
  eks-node-arn       = module.IAM.eks-node-arn
  node-group-name    = var.node-group-name
  eks-node-policy    = module.IAM.eks-node-policy


}

