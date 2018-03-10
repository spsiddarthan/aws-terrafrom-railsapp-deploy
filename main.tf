provider "aws" {
  region = "${var.region}"
}


module "beta" {
  source = "./app"
  key_name = "${var.key_name}"
  private_key_path = "${var.private_key_path}"
  security_group_id = "${var.security_group_id}"
}

module "prod" {
  source = "./app"
  key_name = "${var.key_name}"
  private_key_path = "${var.private_key_path}"
  security_group_id = "${var.security_group_id}"
}

