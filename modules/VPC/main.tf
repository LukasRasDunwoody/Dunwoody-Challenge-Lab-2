# regions for infrastructure
provider "aws" {
  region = var.primary-region
  alias  = "primary"
}

provider "aws" {
  region = var.secondary-region
  alias  = "secondary"
}

# random generator
resource "random_id" "suffix" {
  byte_length = 4
}

# VPC infrastructure
resource "aws_vpc" "lras_primary_vpc" {
  cidr_block           = "${var.cidr-block-vpc}"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"

  provider = aws.primary

  tags = {
      Challengelab = "2"
    }
}

# public subnet for the VPC
resource "aws_subnet" "lras_public_subnet" {
  vpc_id = "${aws_vpc.lras_primary_vpc.id}"
  cidr_block = "${var.cidr-block-subnet-public}"
  availability_zone = "${var.subnet-availability-zone-1}"

  provider = aws.primary

  tags = {
      Challengelab = "2"
    }
}

# internet gateway for the VPC
resource "aws_internet_gateway" "lras_igw" {
  vpc_id = "${aws_vpc.lras_primary_vpc.id}"

  provider = aws.primary
}

# private subnet for the VPC
resource "aws_subnet" "lras_private_subnet_1" {
  vpc_id = "${aws_vpc.lras_primary_vpc.id}"
  cidr_block = "${var.cidr-block-subnet-private-1}"
  availability_zone = "${var.subnet-availability-zone-2}"

  provider = aws.primary

  tags = {
      Challengelab = "2"
    }
}

# 2nd private subnet for the VPC
resource "aws_subnet" "lras_private_subnet_2" {
  vpc_id = "${aws_vpc.lras_primary_vpc.id}"
  cidr_block = "${var.cidr-block-subnet-private-2}"
  availability_zone = "${var.subnet-availability-zone-3}"

  provider = aws.primary

  tags = {
      Challengelab = "2"
    }
}

# ec2 server on the public subnet with a public IP address
resource "aws_instance" "lras_web_server_public_subnet" {
  subnet_id = "${aws_subnet.lras_public_subnet.id}"
  associate_public_ip_address = true
  ami = "${var.public_subnet_ec2_ami}"
  instance_type = "${var.public_subnet_ec2_instance_type}"
  vpc_security_group_ids = [ "${aws_security_group.lras_public_subnet_ec2_security_group.id}" ]
  depends_on = [ aws_security_group.lras_public_subnet_ec2_security_group ]

  tags = {
      Challengelab = "2"
    }
}

# ec2 security group
resource "aws_security_group" "lras_public_subnet_ec2_security_group" {
  name = "public_subnet_ec2_security_group_${random_id.suffix.hex}"
  description = "security group for the ec2 instance on the public subnet"
  vpc_id = "${aws_vpc.lras_primary_vpc.id}"
  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
      Challengelab = "2"
    }
}


# RDS database on the private subnet
resource "aws_db_instance" "lras_private_subnet_rds" {
  allocated_storage = 20
  engine = "mysql"
  engine_version = "5.7"
  instance_class = "${var.private_subnet_rds_instance_class}"
  username = "${var.private_subnet_rds_username}"
  password = "${var.private_subnet_rds_password}"
  storage_encrypted = true
  db_subnet_group_name = aws_db_subnet_group.lras_db_subnet_group.name

  tags = {
      Challengelab = "2"
    }

}

resource "aws_db_subnet_group" "lras_db_subnet_group" {
  name       = "lras_db_subnet_group_${random_id.suffix.hex}"
  subnet_ids = [
    aws_subnet.lras_private_subnet_1.id,
    aws_subnet.lras_private_subnet_2.id
  ]

  tags = {
    Challengelab = "2"
  }
}