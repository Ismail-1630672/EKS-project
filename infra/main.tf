module "vpc" {
    source = "./modules/vpc"
    vpc_cidr = var.vpc_cidr
    project_name = var.project_name
    az_count = var.az_count
    sg_name = var.sg_name
    
    

}