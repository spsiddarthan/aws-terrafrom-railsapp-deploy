resource "aws_instance" "www" {
  ami = "${lookup(var.amis, var.region)}"
  instance_type = "${var.instance_type}"
  tags = {
    Name = "www"
  }
  associate_public_ip_address = true
  key_name = "${var.key_name}"
  vpc_security_group_ids = ["${var.security_group_id}"]

  connection {
        user = "ubuntu"
        type = "ssh"
        private_key = "${file(var.private_key_path)}"
        timeout = "2m"
  }

  provisioner "remote-exec" {
        inline = "${var.exec_commands}"
  }
}