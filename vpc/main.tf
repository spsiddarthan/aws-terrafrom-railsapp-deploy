resource "aws_vpc" "default" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
        tags {
        Name = "terraform-aws-vpc"
    }
}

resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.default.id}"
}

/*
  NAT Instance
*/
resource "aws_security_group" "nat" {
    name = "vpc_nat"
    description = "Allow traffic to pass from the private subnet to the internet"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["${var.private_subnet_cidr}"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["${var.private_subnet_cidr}"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.vpc_cidr}"]
    }
    egress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = "${aws_vpc.default.id}"

    tags {
        Name = "NATSG"
    }
}

resource "aws_instance" "nat" {
    ami = "${lookup(var.amis, var.region)}"
    instance_type = "${var.instance_type}"
    key_name = "${var.key_name}"
    vpc_security_group_ids = ["${aws_security_group.nat.id}"]
    subnet_id = "${aws_subnet.us-west-2c-public.id}"
    associate_public_ip_address = true
    source_dest_check = false

    tags {
        Name = "VPC NAT"
    }
}

resource "aws_eip" "nat" {
    instance = "${aws_instance.nat.id}"
    vpc = true
}

/*
  Public Subnet
*/
resource "aws_subnet" "us-west-2c-public" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block = "${var.public_subnet_cidr}"
    availability_zone = "us-west-2c"

    tags {
        Name = "Public Subnet"
    }
}

resource "aws_route_table" "us-west-2c-public" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }

    tags {
        Name = "Public Subnet"
    }
}

resource "aws_route_table_association" "us-west-2c-public" {
    subnet_id = "${aws_subnet.us-west-2c-public.id}"
    route_table_id = "${aws_route_table.us-west-2c-public.id}"
}

/*
  Private Subnet
*/
resource "aws_subnet" "us-west-2c-private" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block = "${var.private_subnet_cidr}"
    availability_zone = "us-west-2c"

    tags {
        Name = "Private Subnet"
    }
}

resource "aws_route_table" "us-west-2c-private" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        instance_id = "${aws_instance.nat.id}"
    }

    tags {
        Name = "Private Subnet"
    }
}

resource "aws_route_table_association" "us-west-2c-private" {
    subnet_id = "${aws_subnet.us-west-2c-private.id}"
    route_table_id = "${aws_route_table.us-west-2c-private.id}"
}

/*
  Prod security group 
*/
resource "aws_security_group" "prod" {
    name = "vpc_prod"
    description = "Allow incoming HTTP connections."

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress { 
        from_port = 1433
        to_port = 1433
        protocol = "tcp"
        cidr_blocks = ["${var.private_subnet_cidr}"]
    }
    egress { 
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["${var.private_subnet_cidr}"]
    }

    vpc_id = "${aws_vpc.default.id}"

    tags {
        Name = "PRODSG"
    }
}

module "prod" {
  source = "../instance"
  name = "beta"
  key_name = "${var.key_name}"
  private_key_path = "${var.private_key_path}"
  vpc_security_group_ids = ["${aws_security_group.prod.id}"]
  subnet_id = "${aws_subnet.us-west-2c-public.id}" 
  associate_public_ip_address = true
  source_dest_check = false
  tags = "prod server"
}

