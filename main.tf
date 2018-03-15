provider "aws" {
  region = "${var.region}"
}

module "vpc" {
  source = "./vpc"
  key_name = "${var.key_name}"
  private_key_path = "${var.private_key_path}"
}


