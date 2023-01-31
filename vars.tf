# Creating a Variable for ami of type map
variable "ec2_ami" {
  type = map

  default = {
    eu-central-1 = "ami-0416962131234133f"
  }
}

# Creating a Variable for region
variable "region" {
  default = eu-central-1
}


# Creating a Variable for instance_type
variable "instance_type" {    
  type = string
}
