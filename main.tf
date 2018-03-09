provider "aws" {
  region = "${var.region}"
}

module "instances" {
  source = "./instances"
  key_name = "${var.key_name}"
  private_key_path = "${var.private_key_path}"
  security_group_id = "${var.security_group_id}"
}