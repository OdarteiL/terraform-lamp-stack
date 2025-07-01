variable "project" {}
variable "ami_id" {}
variable "instance_type" {}
variable "private_subnet_id" {}
variable "db_sg_id" {}
variable "key_name" {}
variable "mysql_root_password" {
  sensitive = true
}
