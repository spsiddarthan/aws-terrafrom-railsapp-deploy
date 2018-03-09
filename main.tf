provider "aws" {
  region = "${var.region}"
}

module "instances" {
  source = "./instances"
  key_name = "${var.key_name}"
}