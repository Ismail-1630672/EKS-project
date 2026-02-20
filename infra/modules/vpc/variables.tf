variable "vpc_cidr" {
    type = string
    description = "IP range for my vpc"
}

variable "project_name" {
    type = string 
    description = "name of my project"
}

variable "az_count" {
    type = number 
    description = "number of availability zones"
}

variable "sg_name" {
    type= string 
    description = "name of security group"
}

