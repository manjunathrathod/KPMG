provider "aws" {
    region = "eu-west-2"
    access_key = var.aws_access_key
    secret_key = vat.aws_secret_key
}

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = var.public_subent1_name
  }
}
resource "aws_subnet" "public2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = var.public_subent2_name
  }
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = var.private_subent1_name
  }
}

resource "aws_nat_gateway" "example" {
  connectivity_type = "private"
  subnet_id         = aws_subnet.private.id
}

## RDS Instance
resource "aws_db_instance" "default" {
    allocated_storage = 5
    engine         = "mysql"
    engine_version = "8.0.20"
    instance_class = "db.t3.micro"
    name           = "initial_db"
    username       = "${var.db_username}"
    password       = "${var.db_userpasswd}"
}

## Load balancer 
resource "aws_lb" "NLB17" {
    name = "NLB17"
    internal = false
    load_balancer_type = "network"
    subnets = ["${aws_subnet.public1.id}", "${aws_subnet.public2.id}"]
    enable_deletion_protection = false 
}