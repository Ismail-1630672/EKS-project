resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true #crucial for DNS resolution
    enable_dns_support = true #similarly crucial for DNS resolution and resolves hostname to IP address

    tags = {
        Name = "${var.project_name}-vpc"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.my_vpc.id 
    
    tags = {
        Name = "${var.project_name}-igw"
    }

    depends_on = [aws_vpc.my_vpc]
}

data "aws_availability_zones" "available" {
    state = "available"
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.my_vpc.id 
    count = var.az_count
    cidr_block = cidrsubnet(var.vpc_cidr, 8, count.index + 1)
    availability_zone = data.aws_availability_zones.available.names[count.index]
    map_public_ip_on_launch = true #assigns ipv4 addresses to resources inside subnet for internet access

    tags = {
        Name = "public-subnet-${count.index + 1}"
    }

    depends_on = [aws_vpc.my_vpc]
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.my_vpc.id 
    count = var.az_count 
    cidr_block = cidrsubnet(var.vpc_cidr, 8, count.index + 3)
    availability_zone = data.aws_availability_zones.available.names[count.index]
    map_public_ip_on_launch = false 

    tags = {
        Name = "private-subnet-${count.index + 1}"
    }

    depends_on = [aws_vpc.my_vpc]
}

resource "aws_route_table" "public_route" {
    vpc_id = aws_vpc.my_vpc.id 

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id 
    }

    tags = {
        Name = "public-route-table"
    }

    depends_on = [aws_vpc.my_vpc]
}

#now associate public subnets with the route table
resource "aws_route_table_association" "public-rta" {
    count = var.az_count
    route_table_id = aws_route_table.public_route.id 
    subnet_id = aws_subnet.public_subnet[count.index].id 

    depends_on = [aws_vpc.my_vpc, aws_subnet.public_subnet]
}

#NAT gateways (sits in public subet) connect to the internet gateway to allow resources in private subnet internet access
#An elastic IP provides a public IPV4 address which is static (never changes) and attatched
#to NAT gateway, this gives a stable endpoint for communication with the internet 

resource "aws_eip" "ngw_eip" {
    count = var.az_count
    domain = "vpc"

    tags = {
        Name = "nat_gateway_elasticIP-${count.index + 1}"
    }

    depends_on = [aws_vpc.my_vpc]
}

resource "aws_nat_gateway" "ngw" {
    count = var.az_count
    allocation_id = aws_eip.ngw_eip[count.index].id  
    subnet_id = aws_subnet.public_subnet[count.index].id 

    tags = {
        Name = "Nat_gateway"
    }

    depends_on = [aws_vpc.my_vpc, aws_eip.ngw_eip]
}


resource "aws_route_table" "private_route" {
    vpc_id = aws_vpc.my_vpc.id 
    count = var.az_count

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.ngw[count.index].id 
    }

    tags = {
        Name = "private_route_table"
    }

    depends_on = [aws_vpc.my_vpc]

}

resource "aws_route_table_association" "private_rta" {
    count = var.az_count
    route_table_id = aws_route_table.private_route[count.index].id  
    subnet_id = aws_subnet.private_subnet[count.index].id 

    depends_on = [aws_vpc.my_vpc, aws_subnet.private_subnet]
}

resource "aws_security_group" "security-group" {
    name = var.sg_name 
    vpc_id = aws_vpc.my_vpc.id 

    tags = {
        Name = "eks-security-group"
    }
}

resource "aws_vpc_security_group_ingress_rule" "http_traffic" {
    security_group_id = aws_security_group.security-group.id  
    cidr_ipv4 = "0.0.0.0/0"
    from_port = 80 
    ip_protocol = "tcp"
    to_port = 80 

}

resource "aws_vpc_security_group_ingress_rule" "https_traffic" {
    security_group_id = aws_security_group.security-group.id  
    cidr_ipv4 = "0.0.0.0/0"
    from_port = 443 
    ip_protocol = "tcp"
    to_port = 443

}

resource "aws_vpc_security_group_egress_rule" "outbound_traffic" {
    security_group_id = aws_security_group.security-group.id 
    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "-1"
}









