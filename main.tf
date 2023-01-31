resource "aws_instance" "web1" {
    ami = "${lookup(var.ec2_ami, var.region)}" 
    
    instance_type = "t2.micro"    # VPC
    subnet_id = "${aws_subnet.awslab-subnet-private.id}"    # Security Group
    vpc_security_group_ids = ["${aws_security_group.ssh-allowed.id}"]    # the Public SSH key
    key_name = "${aws_key_pair.eu-central-1-region-key-pair.id}"    # nginx installation
    provisioner "file" {
        source = "nginx.sh"
        destination = "/tmp/nginx.sh"
    }    provisioner "remote-exec" {
        inline = [
             "chmod +x /tmp/nginx.sh",
             "sudo /tmp/nginx.sh"
        ]
    }    connection {
        user = "${var.EC2_USER}"
        private_key = "${file("${var.PRIVATE_KEY_PATH}")}"
    }
}

resource "aws_instance" "db1" {
    ami = "${lookup(var.AMI, var.AWS_REGION)}"
    instance_type = "t2.micro"    # VPC
    subnet_id = "${aws_subnet.prod-subnet-public-1.id}"    # Security Group
    vpc_security_group_ids = ["${aws_security_group.priv-ssh-allowed.id}"]    # the Public SSH key
    key_name = "${aws_key_pair.eu-central-1-region-key-pair.id}"    # nginx installation
}
// Sends your public key to the instance
resource "aws_key_pair" "eu-central-1-region-key-pair" {
    key_name = "eu-central-1-region-key-pair"
    public_key = "${file(var.PUBLIC_KEY_PATH)}"
}