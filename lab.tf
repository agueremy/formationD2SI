provider "aws" {
}

resource "aws_vpc" "VPC_main" {
  cidr_block = "172.25.0.0/16"

  tags {
    Name = "VPC-AGU"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = "${aws_vpc.VPC_main.id}"
  cidr_block = "172.25.0.0/24"

  tags {
    Name = "AGU-pub"
  }
}

resource "aws_internet_gateway" "gwAGU" {
  vpc_id = "${aws_vpc.VPC_main.id}"

  tags {
    Name = "gwAGU"
  }
}

resource "aws_route_table" "rt-AGU" {
  vpc_id = "${aws_vpc.VPC_main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gwAGU.id}"
  }

  tags {
    Name = "rt-AGU"
  }
}
