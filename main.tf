provider "aws" {
  region = "${var.region}"
}

module "instances" {
  source = "./instances"
  key_name = "${var.key_name}"
  security_group_id = "${var.security_group_id}"
}