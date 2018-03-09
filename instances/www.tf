resource "aws_instance" "www" {
  ami = "${lookup(var.amis, var.region)}"
  instance_type = "${var.instance_type}"
  tags = {
    Name = "www"
  }
  associate_public_ip_address = true
  key_name = "${var.key_name}"
  vpc_security_group_ids = ["${var.security_group_id}"]
  user_data = "${file("${path.module}/install-rails-and-start-app.sh")}"
}