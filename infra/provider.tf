terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.26.0"
    }
  }

  backend "s3" {
    bucket = "eks-project-ismail"
    key    = "terraform.tfstate"
    region = "eu-west-2"
    encrypt = true
    use_lockfile = true #important for statelocking to prevent corruption of statefile
    
  }
}




provider "aws" {
  region = "eu-west-2"
}