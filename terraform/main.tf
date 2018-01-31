# Configure the AWS Provider
provider "aws" {
  access_key = "AKIAJWXP3F57JSSFK4HA"
  secret_key = "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"
  region     = "us-east-1"
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
