resource “aws_vpc” “awslab-vpc” {
    cidr_block = “172.16.0.0/16”
    enable_dns_support = “true” 
    enable_dns_hostnames = “true”
    enable_classiclink = “false”
    instance_tenancy = “default”    
    
    tags {
        Name = “awslab-vpc”
    }
}

resource “aws_subnet” “awslab-subnet-public” {
    vpc_id = “${aws_vpc.awslab-vpc.id}”
    cidr_block = “172.16.1.0/24”
    map_public_ip_on_launch = “true” //it makes this a public subnet
    availability_zone = “${region}”    
    
    tags {
        Name = “awslab-subnet-public-1”
    }
}

resource “aws_subnet” “awslab-subnet-private” {
    vpc_id = “${aws_vpc.awslab-vpc.id}”
    cidr_block = “172.16.2.0/24”
    map_public_ip_on_launch = “true” //it makes this a private subnet
    availability_zone = “${region}”    
    
    tags {
        Name = “awslab-subnet-private-1”
    }
}