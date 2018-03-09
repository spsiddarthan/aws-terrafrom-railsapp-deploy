resource "aws_instance" "www-beta" {
  ami = "${lookup(var.amis, var.region)}"
  instance_type = "${var.instance_type}"
  tags = {
    Name = "www-beta"
  }
  associate_public_ip_address = true
  key_name = "${var.key_name}"
  vpc_security_group_ids = ["${var.security_group_id}"]
}