resource "aws_internet_gateway" "awslab-igw" {
    vpc_id = "${aws_vpc.awslab-vpc.id}"
    tags {
        Name = "awslab-igw"
    }
}

resource "aws_route_table" "awslab-rt-internet" {
    vpc_id = "${aws_vpc.awslab-vpc.id}"
    
    route {
        //associated subnet can reach everywhere
        cidr_block = "0.0.0.0/0"         //CRT uses this IGW to reach internet
        gateway_id = "${aws_internet_gateway.awslab-igw.id}" 
    }
    
    tags {
        Name = "awslab-rt-internet"
    }
}

resource "aws_route_table_association" "prod-crta-public-subnet-1"{
    subnet_id = "${aws_subnet.awslab-subnet-public-1.id}"
    route_table_id = "${aws_route_table.awslab-rt-internet.id}"
}

resource "aws_security_group" "ssh-allowed" {
    vpc_id = "${aws_vpc.awslab-vpc.id}"
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }    
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"        
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags {
        Name = "ssh-allowed"   
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }    
    tags {
        Name = "http-allowed"
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }    
    tags {
        Name = "https-allowed"
    }
    ingress {
        from_port = 0
        to_port = 65535
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }    
    tags {
        Name = "ping-allowed"
    }
    ingress {
        from_port = 3110
        to_port = 3110
        protocol = "tcp"
        cidr_blocks = ["172.16.1.0/24"]
    }    
    tags {
        Name = "priv-custom-allowed"
    }
    ingress {
        from_port = 0
        to_port = 65535
        protocol = "icmp"
        cidr_blocks = ["172.16.1.0/24"]
    }    
    tags {
        Name = "priv-ping-allowed"
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"        
        cidr_blocks = ["172.16.1.0/24"]
    }
    tags {
        Name = "priv-ssh-allowed"   
    }

}