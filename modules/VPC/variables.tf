# variables for deploying in regions
variable "primary-region" {
  type        = string
  default     = "us-east-1"
  description = "primary region for your infrastructure"
}

variable "secondary-region" {
  type        = string
  default     = "us-west-2"
  description = "secondary region for your infrastructure"
}

# variables used for the VPCs
variable "cidr-block-vpc" {
  type = string
  default = "10.0.0.0/16"
  description = "cidr block for the vpc"
}

variable "cidr-block-subnet-public" {
  type = string
  default = "10.0.1.0/24"
  description = "cidr block for the public subnet"
}

variable "cidr-block-subnet-private-1" {
  type = string
  default = "10.0.2.0/24"
  description = "cidr block for the private subnet"
}

variable "cidr-block-subnet-private-2" {
  type = string
  default = "10.0.3.0/24"
  description = "cidr block for the private subnet"
}

variable "subnet-availability-zone-1" {
  type = string
  default = "us-east-1a"
  description = "availability zone for a subnet"
}

variable "subnet-availability-zone-2" {
  type = string
  default = "us-east-1b"
  description = "availability zone for a subnet"
}

variable "subnet-availability-zone-3" {
  type = string
  default = "us-east-1c"
  description = "availability zone for a subnet"
}

# variables for EC2 instance configuration
variable "public_subnet_ec2_ami" {
  type        = string
  default     = "ami-0230bd60aa48260c6"
  description = "ami for us-east-1"
}

variable "public_subnet_ec2_instance_type" {
  type        = string
  default     = "t3.micro"
  description = "computational compacity of the ec2 instance"
}   

variable "private_subnet_rds_instance_class" {
  type        = string
  default     = "db.t3.micro"
  description = "computational compacity of the RDS database"
}   

variable "private_subnet_rds_username" {
  type        = string
  default     = "administrator"
  description = "RDS Username"
}

variable "private_subnet_rds_password" {
  type        = string
  default     = "password01!"
  description = "RDS Username"
}   