variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
    description = "CIDR for the Public Subnet"
    default = "10.0.0.0/24"
}

variable "private_subnet_cidr" {
    description = "CIDR for the Private Subnet"
    default = "10.0.1.0/24"
}

variable "instance_type" {
  default = "t2.micro"
}

# Amazon Linux AMI
variable "amis" {
  default = {
    us-west-2 = "ami-79873901"  #most recent t2.micro AMI as of 9th March, 2018.
  }
}

variable "region" {
  default = "us-west-2"
}

variable "key_name" {}
variable "private_key_path" {}
variable "default" {
    default = true
}