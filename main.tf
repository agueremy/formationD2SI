provider "aws" {}

terraform {
  backend "s3" {
    bucket = "aguterraform.tfstate"
    key    = "core/infra"
    region = "eu-west-1"
  }
}

resource "aws_vpc" "VPC_main" {
  cidr_block = "10.1.0.0/16"

  tags {
    Name = "VPC-AGU"
  }
}

resource "aws_subnet" "subnet-AGU1" {
  vpc_id     = "${aws_vpc.VPC_main.id}"
  cidr_block = "10.1.0.0/24"
  availability_zone  = "eu-west-1c"

  tags {
    Name = "AGU-pub"
  }
}

resource "aws_subnet" "subnet-AGU2" {
  vpc_id     = "${aws_vpc.VPC_main.id}"
  cidr_block = "10.1.1.0/24"
  availability_zone  = "eu-west-1a"

  tags {
    Name = "AGU-pub2"
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

resource "aws_route_table_association" "ra-AGU" {
  subnet_id      = "${aws_subnet.subnet-AGU1.id}"
  route_table_id = "${aws_route_table.rt-AGU.id}"
}
