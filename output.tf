output "vpc_core_id"{
        value = "${aws_vpc.VPC_main.id}"
}

output "subnet_pub_id"{
	value = "${aws_subnet.subnet-AGU1.id}"
}
