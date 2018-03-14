resource "aws_instance" "www"{
  ami = "${lookup(var.amis, var.region)}"
  instance_type = "${var.instance_type}"
  associate_public_ip_address = "${var.associate_public_ip_address}"
  key_name = "${var.key_name}"
  vpc_security_group_ids =  ["${var.vpc_security_group_ids[0]}"]
  source_dest_check = "${var.source_dest_check}"
  subnet_id = "${var.subnet_id}"
  tags {
        Name = "${var.tags}"
  }
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

resource "aws_eip" "www" {
    instance = "${aws_instance.www.id}"
    vpc = true
}