variable "project" {
  description = "Project name"
  type        = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnet_cidr" {
  type = string
}

variable "private_subnet_cidr" {
  type = string
}

variable "az" {
  type        = string
  description = "Availability zone for subnets"
}

variable "public_subnet_cidr_az2" {}
variable "az2" {}

