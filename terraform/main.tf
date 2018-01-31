variable "vpc_cidr" {
  default = "10.0.0.0/16"  
}

resource "aws_vpc" "main" {
  cidr_block = "${var.vpc_cidr}"
}

resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"
}
