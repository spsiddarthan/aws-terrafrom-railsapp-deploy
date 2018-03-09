variable "region" {
  default = "us-west-2"
}
variable "key_name" {}
variable "security_group_id" {}
variable "instance_type" {
  default = "t2.micro"
}
# Amazon Linux AMI
variable "amis" {
  default = {
    us-west-2 = "ami-79873901"  #most recent t2.micro AMI as of 9th March, 2018.
  }
}