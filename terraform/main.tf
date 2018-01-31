# AWS configuration
provider "aws" {
  access_key = "${length(var.aws["access_key"]) > 1 ? var.aws["access_key"] : ""}"
  profile    = "${length(var.aws["profile"]) > 1 ? var.aws["profile"] : ""}"
  secret_key = "${length(var.aws["secret_key"]) > 1 ? var.aws["secret_key"] : ""}"
  region     = "${length(var.aws["region"]) > 1 ? var.aws["region"] : ""}"
}


variable "vpc_cidr" {
  default = "10.0.0.0/16"  
}

resource "aws_vpc" "main" {
  cidr_block = "${var.vpc_cidr}"
}

resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"
}
